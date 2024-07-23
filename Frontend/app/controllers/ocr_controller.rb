# class OcrController < ApplicationController
#   def new
#   end

#   def create
#     # Path to your Python script
#     script_path = Rails.root.join('../Backend/scripts/ocr_script.py').to_s

#     # Call the Python script
#     output, status = Open3.capture2e("python #{script_path}")

#     if status.success?
#       render plain: output
#     else
#       render plain: output, status: :unprocessable_entity
#     end
#   end
# end
class OcrController < ApplicationController
  require 'httparty'

  ALLOWED_FILE_TYPES = %w(image/jpeg image/png image/jpg application/pdf)
  MAX_FILE_SIZE = 5.megabytes

  def create
    doc_type = params[:doc_type]
    file = params[:file]

    if doc_type && file && valid_file_type?(file)
      result = analyze_image(file)

      if result == 'true'
        @user.update( "#{doc_type}_doc": file)
        upload_to_gcs(@user.send("#{doc_type}_doc"))
        render json: {message: 'Document uploaded successfully!'}, status: :ok
      else
        render json: {message: 'Failed to analyse image'}, status: :unprocessable_entity
      end
    else
      render json: {errors: 'Invalid parameters'}, status: :unprocessable_entity
    end
  end

  private

  def analyze_image(file)
    response = HTTParty.post('http://127.0.0.1:5000/analyze', body: {file: file}, headers: {"Content-Type" => "multipart/form-data"})
    result = response.parsed_response["result"]
    result
  end

  def upload_to_gcs(file)
    storage = Google::Cloud::Storage.new
    bucket  = storage.bucket ENV['ry_bucket_test']
    blob = bucket.create_file file.path, SecureRandom.uuid

    file.update(file_url: blob.public_url)
  end

  def valid_file_type?(file)
    ALLOWED_FILE_TYPES.include?(file.content_type) && file.size <= MAX_FILE_SIZE
  end
end