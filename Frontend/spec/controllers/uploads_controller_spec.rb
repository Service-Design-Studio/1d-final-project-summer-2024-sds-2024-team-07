# spec/controllers/uploads_controller_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe UploadsController, type: :controller do
  let(:uploaded_file) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test_file.txt'), 'text/plain') }
  let(:user) { create(:user, session_id: 'test_session_id') }

  before do
    allow(controller).to receive(:session).and_return(user_id: 'test_session_id')
  end

  describe 'POST #create' do
    context 'when a file is uploaded successfully' do
      before do
        allow(controller).to receive(:send_file_to_flask_backend).and_return({ 'result' => true })
        allow(controller).to receive(:upload_to_gcloud).and_return('http://gcloud_file_url')
      end

      it 'saves the file temporarily and returns success' do
        allow(File).to receive(:open).and_call_original
        allow(File).to receive(:open).with(anything, 'wb').and_yield(double('file', write: true))

        post :create, params: { file: uploaded_file, file_type: 'passport' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['result']).to eq(true)
        expect(JSON.parse(response.body)['message']).to eq('File processed successfully and URL generated')
      end
    end

    context 'when file processing fails' do
      before do
        allow(controller).to receive(:send_file_to_flask_backend).and_return({ 'result' => false })
      end

      it 'returns an error message' do
        post :create, params: { file: uploaded_file, file_type: 'passport' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['result']).to eq(false)
        expect(JSON.parse(response.body)['message']).to eq('File processing failed')
      end
    end
  end

  describe 'private methods' do
    describe '#send_file_to_flask_backend' do
      let(:file_path) { Rails.root.join('spec/fixtures/files/test_file.txt') }
      let(:file_type) { 'passport' }

      it 'sends the file to the Flask backend and returns the response' do
        response_body = { 'result' => true }.to_json
        # stub_request(:post, "https://flask-app-44nyvt7saq-de.a.run.app/upload/passport")
        stub_request(:post, "http://127.0.0.1:5000/upload/passport")
          .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

        response = controller.send(:send_file_to_flask_backend, file_path, file_type)
        expect(response['result']).to eq(true)
      end
    end

    describe '#upload_to_gcloud' do
      let(:file_path) { Rails.root.join('spec/fixtures/files/test_file.txt') }
      let(:uuid) { SecureRandom.uuid }
      let(:original_filename) { 'test_file.txt' }

      it 'uploads the file to Google Cloud Storage and returns the public URL' do
        gcs_file_double = double('gcs_file', public_url: 'http://gcloud_file_url')
        bucket_double = double('bucket', create_file: gcs_file_double)
        allow($storage).to receive(:bucket).and_return(bucket_double)

        file_url = controller.send(:upload_to_gcloud, file_path, uuid, original_filename)
        expect(file_url).to eq('http://gcloud_file_url')
      end
    end
  end
  
end
