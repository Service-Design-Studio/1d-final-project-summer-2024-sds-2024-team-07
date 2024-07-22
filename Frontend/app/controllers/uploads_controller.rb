class UploadsController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @result = params[:result]
  end

  def create
    uploaded_file = params[:file]
    file_type = params[:file_type]
    file_path = Rails.root.join('tmp', uploaded_file.original_filename)

    if uploaded_file.nil?
      render json: { result: false, message: 'No file uploaded' }, status: :unprocessable_entity
      return
    end

    begin
      # Save the file temporarily to the server
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_file.read)
      end

      # Send the file to the Flask backend
      response = send_file_to_flask_backend(file_path, file_type)

      if response['result']
        result = 'File processed successfully: ' + response.to_s
      else
        result = 'File processing failed: ' + response.to_s
      end
    rescue StandardError => e
      result = "File upload failed: #{e.message}"
    ensure
      File.delete(file_path) if File.exist?(file_path)
    end

    respond_to do |format|
      format.json { render json: { result: response['result'], message: result } }
    end
  end

  private

  def send_file_to_flask_backend(file_path, file_type)
    endpoint_map = {
      'passport' => '/upload/passport',
      'employment_pass' => '/upload/employment_pass',
      'income_tax' => '/upload/income_tax',
      'proof_of_address' => '/upload/proof_of_address',
      'payslip' => '/upload/payslip'
    }

    endpoint = endpoint_map[file_type] || '/upload/generic'
    uri = URI.parse("http://127.0.0.1:5000#{endpoint}")
    request = Net::HTTP::Post.new(uri)
    form_data = [['file', File.open(file_path)]]
    request.set_form form_data, 'multipart/form-data'

    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  rescue JSON::ParserError => e
    { 'result' => false, 'message' => "Failed to parse JSON response from Flask: #{e.message}" }
  end
end
