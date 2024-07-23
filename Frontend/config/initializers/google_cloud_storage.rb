# config/initializers/google_cloud_storage.rb
require "google/cloud/storage"

# Method to get credentials based on environment
def google_cloud_credentials
  case Rails.env
  when "production"
    {
      project_id: "dbsdoccheckteam7",
      credentials: Rails.root.join("config", "credentials", "development1.json").to_s,
      bucket_name: "dbs-bucket"
    }
  else
    {
      project_id: "dbsdoccheckteam7",
      credentials: Rails.root.join("config", "credentials", "development1.json").to_s,
      bucket_name: "dbs-development-bucket"
    }
  end
end

# Configure Google Cloud Storage
Google::Cloud::Storage.configure do |config|
  credentials = google_cloud_credentials
  config.project_id = credentials[:project_id]
  config.credentials = credentials[:credentials]
end

$storage = Google::Cloud::Storage.new(
  project_id: google_cloud_credentials[:project_id],
  credentials: google_cloud_credentials[:credentials]
)

$bucket_name = google_cloud_credentials[:bucket_name]
