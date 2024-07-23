class User < ApplicationRecord
  before_create :generate_uuid
  after_create :upload_uuid_to_bucket

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
    Rails.logger.info "Generated UUID: #{self.uuid}"
  end

  def upload_uuid_to_bucket
    Rails.logger.info "Starting upload to Google Cloud Storage bucket: #{ENV['ry_bucket_test']}"
    
    begin
      storage = Google::Cloud::Storage.new
      bucket = storage.bucket(ENV['ry_bucket_test'])
      
      if bucket.nil?
        Rails.logger.error "Bucket not found: #{ENV['ry_bucket_test']}"
        return
      end

      file = bucket.create_file(StringIO.new(uuid), "#{uuid}.txt")
      
      if file
        Rails.logger.info "Successfully uploaded UUID file: #{file.name}"
      else
        Rails.logger.error "File upload failed"
      end
    rescue StandardError => e
      Rails.logger.error "Failed to upload UUID to bucket: #{e.message}"
    end
  end
end
