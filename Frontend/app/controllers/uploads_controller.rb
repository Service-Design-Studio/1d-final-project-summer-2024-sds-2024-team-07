class UploadsController < ApplicationController
  def new
  end

  def create
    uploaded_file = params[:file]
    file_path = Rails.root.join('tmp', uploaded_file.original_filename)

    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    google_cloud_storage_service = GoogleCloudStorageService.new
    google_cloud_storage_service.upload_file(file_path.to_s)

    flash[:notice] = 'File uploaded successfully'
    redirect_to new_upload_path
  rescue StandardError => e
    flash[:alert] = "File upload failed: #{e.message}"
    redirect_to new_upload_path
  end
end
