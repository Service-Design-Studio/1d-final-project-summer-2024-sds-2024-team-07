Rails.application.routes.draw do
  get 'uploads/new'
  get 'uploads/create'

  get 'pages/cardoptions', to: 'pages#cardoptions', as: 'pages_cardoptions'
  get 'pages/apply', to: 'pages#apply', as: 'pages_apply'
  get 'pages/documentupload', to: 'pages#documentupload', as: 'pages_documentupload'
  get 'pages/applicationform', to: 'pages#applicationform', as: 'pages_applicationform'
  get 'pages/applicationchecklist', to: 'pages#applicationchecklist', as: 'pages_applicationchecklist'
  get 'employment_passport', to: 'your_controller#employment_passport', as: 'employment_passport'
  get 'verify_details', to: 'your_controller#verify_details', as: 'verify_details'
  get 'create_pin', to: 'your_controller#create_pin', as: 'create_pin'
  post 'ocr', to: 'ocr#create'
  get 'ocr/new', to: 'ocr#new'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  resources :uploads, only: [:new, :create]
  resources :users do
    collection do
      post 'apply', to: 'users#apply', as: 'apply'
      post 'upload_document', to: 'users#upload_document', as: 'upload_document'
    end
  end

  get 'users_list', to: 'users#index', as: 'users_list'
  # Defines the root path route ("/")
  # root "home#index"
  root "pages#apply"
end
