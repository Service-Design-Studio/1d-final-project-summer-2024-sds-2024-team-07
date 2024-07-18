require 'net/http'
require 'uri'
require 'json'

class UploadsController < ApplicationController
  def new
    @result = params[:result]
  end

  def create
    uploaded_file = params[:file]
    file_path = Rails.root.join('tmp', uploaded_file.original_filename)

    # Save the file temporarily to the server
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    # Send the file to the Flask backend
    response = send_file_to_flask_backend(file_path)

    if response['result']
      @result = 'File processed successfully: ' + response.to_s
    else
      @result = 'File processing failed: ' + response.to_s
    end

    redirect_to new_upload_path(result: @result)
  rescue StandardError => e
    flash[:alert] = "File upload failed: #{e.message}"
    redirect_to new_upload_path
  end

  private

  def send_file_to_flask_backend(file_path)
    uri = URI.parse('http://127.0.0.1:5000/upload')
    request = Net::HTTP::Post.new(uri)
    form_data = [['file', File.open(file_path)]]
    request.set_form form_data, 'multipart/form-data'

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end
end