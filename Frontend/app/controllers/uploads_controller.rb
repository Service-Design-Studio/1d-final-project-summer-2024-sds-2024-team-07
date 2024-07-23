class UploadsController < ApplicationController
  protect_from_forgery with: :null_session

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
      puts "File saved temporarily at: #{file_path}"

      # Send the file to the Flask backend
      response = send_file_to_flask_backend(file_path, file_type)
      puts "Response from Flask: #{response}"

      if response['result'] == 'true'
        user = User.find_by(session_id: session[:user_id]) # Use the session ID to find the user
        if user
          uuid = SecureRandom.uuid
          column_name = "doc_#{file_type}"
          user.update(column_name => uuid)
          puts "Updated user #{user.id} with UUID #{uuid} for #{column_name}"

          # Upload the file to Google Cloud Storage
          upload_to_gcloud(file_path, uuid, uploaded_file.original_filename)
        end
        result = 'File processed successfully and UUID generated'
      else
        result = 'File processing failed'
      end
    rescue StandardError => e
      result = "File upload failed: #{e.message}"
    ensure
      # File.delete(file_path) if File.exist?(file_path)
    end

    render json: { result: response['result'], message: result }
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

  def upload_to_gcloud(file_path, uuid, original_filename)
    begin
      bucket = $storage.bucket $bucket_name
      file_name = "#{uuid}_#{original_filename}"
      puts "Uploading file: #{file_path} to GCS as #{file_name}"

      # Ensure the file is being read correctly before uploading
      file = File.open(file_path)
      bucket.create_file file, file_name
      file.close

      puts "File uploaded successfully."
    rescue => e
      puts "Failed to upload file: #{e.message}"
      raise "File upload failed: #{e.message}"
    end
  end
end
