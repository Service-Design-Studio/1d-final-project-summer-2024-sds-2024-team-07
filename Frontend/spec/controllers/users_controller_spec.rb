# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    { name: "Test User", passport_number: "A1234567", passport_expiry: "2025-01-01", date_of_birth: "1990-01-01" }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  let(:new_attributes) {
    { name: "Updated User" }
  }

  let!(:user) { create(:user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it 'renders a successful response (i.e. to display the "new" template)' do
        post :create, params: { user: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the requested user' do
        patch :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(user.name).to eq("Updated User")
      end

      it 'redirects to the user' do
        patch :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(response).to redirect_to(user)
      end
    end

    context 'with invalid parameters' do
      it 'renders a successful response (i.e. to display the "edit" template)' do
        patch :update, params: { id: user.id, user: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested user' do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_url)
    end
  end

  describe 'POST #apply' do
    it 'creates a new user with a session ID and redirects to document upload page' do
      expect {
        post :apply
      }.to change(User, :count).by(1)

      new_user = User.last
      expect(new_user.session_id).not_to be_nil
      expect(response).to redirect_to(pages_documentupload_path)
    end
  end
end
