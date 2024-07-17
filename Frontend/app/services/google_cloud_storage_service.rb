class GoogleCloudStorageService
  def initialize
    # Hardcoded bucket name
    @bucket_name = "dbs-development-bucket"
    @bucket = $storage.bucket(@bucket_name)
    raise "Bucket not found" unless @bucket
  end

  def upload_file(file_path)
    raise "Bucket not found" unless @bucket

    file_name = File.basename(file_path)
    @bucket.create_file(file_path, file_name)
  end
end
