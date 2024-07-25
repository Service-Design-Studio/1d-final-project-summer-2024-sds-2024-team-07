# app/controllers/uploads_controller.rb
class UploadsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    uploaded_file = params[:file]
    file_type = params[:file_type]

    if uploaded_file.nil?
      render json: { result: false, message: 'No file uploaded' }, status: :unprocessable_entity
      return
    end

    file_path = Rails.root.join('tmp', uploaded_file.original_filename)

    begin
      # Save the file temporarily to the server
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_file.read)
      end
      # puts "File saved temporarily at: #{file_path}"

      # Send the file to the Flask backend
      response = send_file_to_flask_backend(file_path, file_type)
      # puts "Response from Flask: #{response}"

      if response['result'] == 'true'
        user = User.find_by(session_id: session[:user_id]) # Use the session ID to find the user
        if user
          uuid = SecureRandom.uuid
          column_name = "doc_#{file_type}"
          file_url = upload_to_gcloud(file_path, uuid, uploaded_file.original_filename)
          user.update(column_name => file_url)
          # puts "Updated user #{user.id} with URL #{file_url} for #{column_name}"
        end
        result = 'File processed successfully and URL generated'
        render json: { result: 'true', message: result, file_id: uuid }
      else
        result = 'File processing failed'
        render json: { result: 'false', message: result }
      end
    rescue StandardError => e
      result = "File upload failed: #{e.message}"
      render json: { result: 'false', message: result }
    ensure
      # File.delete(file_path) if File.exist?(file_path)
    end
  end

  def delete_document
    file_type = params[:file_type]
    user = User.find_by(session_id: session[:user_id])

    if user
      column_name = "doc_#{file_type}"
      if user[column_name].present?
        user.update(column_name => nil)
        render json: { result: 'true', message: 'File deleted successfully' }
      else
        render json: { result: 'false', message: 'File not found' }
      end
    else
      render json: { result: 'false', message: 'User not found' }
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
    uri = URI.parse("https://flask-app-44nyvt7saq-de.a.run.app#{endpoint}")

    request = Net::HTTP::Post.new(uri)
    form_data = [['file', File.open(file_path)]]
    request.set_form form_data, 'multipart/form-data'

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  rescue JSON::ParserError => e
    { 'result' => false, 'message' => "Failed to parse JSON response from Flask: #{e.message}" }
  rescue StandardError => e
    { 'result' => false, 'message' => "Error sending file to Flask: #{e.message}" }
  end

  def upload_to_gcloud(file_path, uuid, original_filename)
    begin
      bucket = $storage.bucket $bucket_name
      file_name = "#{uuid}_#{original_filename}"
      puts "Uploading file: #{file_path} to GCS as #{file_name}"

      file = File.open(file_path)
      gcs_file = bucket.create_file file, file_name
      file.close

      # puts "File uploaded successfully."
      gcs_file.public_url
    rescue => e
      # puts "Failed to upload file: #{e.message}"
      raise "File upload failed: #{e.message}"
    end
  end
end
