# spec/controllers/users_controller_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) { attributes_for(:user) }

      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { attributes_for(:user, name: nil) }

      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { user: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: "Updated User" } }

      it "updates the requested user" do
        put :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(user.name).to eq("Updated User")
      end

      it "redirects to the user" do
        put :update, params: { id: user.id, user: new_attributes }
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { name: nil } }

      it "returns a success response (i.e., to display the 'edit' template)" do
        put :update, params: { id: user.id, user: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_url)
    end
  end

  describe "POST #apply" do
    it "creates a new user with a session_id and redirects to document upload page" do
      expect {
        post :apply
      }.to change(User, :count).by(1)

      expect(session[:user_id]).not_to be_nil
      expect(User.last.session_id).to eq(session[:user_id])
      expect(response).to redirect_to(pages_documentupload_path)
    end
  end
end

# Add this new describe block for integration tests
RSpec.describe "Users Integration", type: :request do
  let(:valid_attributes) { attributes_for(:user) }
  let(:invalid_attributes) { attributes_for(:user, name: nil) }

  describe "User flow" do
    it "allows a user to be created, updated, and deleted" do
      # Create a new user
      post users_path, params: { user: valid_attributes }
      expect(response).to redirect_to(user_path(User.last))

      user = User.last
      expect(user.name).to eq(valid_attributes[:name])

      # Update the user
      new_name = "Updated Name"
      put user_path(user), params: { user: { name: new_name } }
      expect(response).to redirect_to(user_path(user))

      user.reload
      expect(user.name).to eq(new_name)

      # Delete the user
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)

      expect(response).to redirect_to(users_path)
    end
  end

  describe "User application process" do
    it "allows a user to apply and upload a document" do
      # Apply as a new user
      post apply_users_path
      expect(response).to redirect_to(pages_documentupload_path)

      user = User.last
      expect(user.session_id).not_to be_nil

      # Stub the request to the Flask backend
    stub_request(:post, "http://127.0.0.1:5000/upload/generic")
    .with(
      body: include(fixture_file_upload('test_file.txt', 'application/pdf').read),  # Include file content
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type' => 'multipart/form-data',
        'Host' => '127.0.0.1:5000',
        'User-Agent' => 'Ruby'
      }
    )
    .to_return(status: 200, body: "", headers: {})

      # Simulate document upload
      post uploads_path, params: { file: fixture_file_upload('test_file.txt', 'application/pdf') }
      expect(response).to be_successful

      # Check if the document was associated with the user (adjust based on your data model)
      user.reload
    end
  end

  describe "User listing and viewing" do
    before { create_list(:user, 3) }

    it "allows viewing the list of users and individual user details" do
      # List all users
      get users_path
      expect(response).to be_successful
      expect(response.body).to include(User.first.name)
      expect(response.body).to include(User.last.name)

      # View a specific user
      user = User.first
      get user_path(user)
      expect(response).to be_successful
      expect(response.body).to include(user.name)
    end
  end
end
