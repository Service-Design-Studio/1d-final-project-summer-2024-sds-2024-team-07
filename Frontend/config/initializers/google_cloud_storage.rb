# config/initializers/google_cloud_storage.rb
require "google/cloud/storage"

# Hardcoded configuration
project_id = "dbsdoccheckteam7"
credentials_path = Rails.root.join("config", "credentials", "development1.json").to_s

Google::Cloud::Storage.configure do |config|
  config.project_id = project_id
  config.credentials = credentials_path
end

$storage = Google::Cloud::Storage.new(project_id: project_id, credentials: credentials_path)
