# spec/controllers/pages_controller_spec.rb
require 'rails_helper'

# Unit Testing
RSpec.describe PagesController, type: :controller do
  describe 'GET #apply' do
    it 'renders the apply template' do
      get :apply
      expect(response).to render_template(:apply)
    end

    it 'uses the application_applypage layout' do
      get :apply
      expect(response).to render_template(layout: 'application_applypage')
    end
  end

  describe 'GET #documentupload' do
    it 'renders the documentupload template' do
      get :documentupload
      expect(response).to render_template(:documentupload)
    end

    it 'uses the application_documentuploadpage layout' do
      get :documentupload
      expect(response).to render_template(layout: 'application_documentuploadpage')
    end
  end

  describe 'GET #applicationform' do
    it 'renders the applicationform template' do
      get :applicationform
      expect(response).to render_template(:applicationform)
    end

    it 'uses the application_formpage layout' do
      get :applicationform
      expect(response).to render_template(layout: 'application_formpage')
    end
  end

  describe 'GET #applicationchecklist' do
    it 'renders the applicationchecklist template' do
      get :applicationchecklist
      expect(response).to render_template(:applicationchecklist)
    end

    it 'uses the application_checklistpage layout' do
      get :applicationchecklist
      expect(response).to render_template(layout: 'application_checklistpage')
    end
  end
end
