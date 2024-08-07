require 'rails_helper'

RSpec.describe GoogleCloudStorageService do
  let(:bucket_name) { 'dbs-development-bucket' }
  let(:bucket) { instance_double('Google::Cloud::Storage::Bucket') }
  let(:storage) { instance_double('Google::Cloud::Storage::Project') } # Adjust based on the actual class

  before do
    # Mock the global $storage variable
    $storage = instance_double('Google::Cloud::Storage::Project')
    allow($storage).to receive(:bucket).with(bucket_name).and_return(bucket)
  end

  describe '#initialize' do
    context 'when the bucket is found' do
      it 'does not raise an error' do
        expect { GoogleCloudStorageService.new }.not_to raise_error
      end
    end

    context 'when the bucket is not found' do
      let(:bucket) { nil }

      it 'raises an error' do
        expect { GoogleCloudStorageService.new }.to raise_error('Bucket not found')
      end
    end
  end

  describe '#upload_file' do
    let(:service) { GoogleCloudStorageService.new }
    let(:file_path) { Rails.root.join('spec/fixtures/files/test_file.txt') }
    let(:file_name) { 'test_file.txt' }

    before do
      allow(File).to receive(:basename).with(file_path).and_return(file_name)
      allow(bucket).to receive(:create_file).with(file_path, file_name)
    end

    it 'uploads the file to the bucket' do
      expect(bucket).to receive(:create_file).with(file_path, file_name)
      service.upload_file(file_path)
    end

    context 'when the bucket is not found' do
      before do
        allow($storage).to receive(:bucket).with(bucket_name).and_return(nil)
      end

      it 'raises an error' do
        expect { service.upload_file(file_path) }.to raise_error('Bucket not found')
      end
    end
  end
end
