Rails.application.routes.draw do

  resources :feedbacks
  resources :attachments

  resources :contactables

  resources :contacts

  get 'transactions' => 'transactions#index', as: 'transactions'

  get '/apis/:action', :controller => 'apis'

  mount DynamicFormsEngine::Engine => "/dynamic_forms_engine"

  get 'dynamic_forms_engine/dynamic_form_entries/:id/transactions/new' => 'transactions#new', as: 'new_transaction'

  post 'dynamic_forms_engine/dynamic_form_entries/:id/transactions/create' => 'transactions#create'

  # get 'transactions/index' => 'transactions#index'

  get 'tenant_applications' => 'dynamic_forms_engine/dynamic_form_entries#tenant_applications', as: 'tenant_applications'

  get 'field_values' => 'dynamic_forms_engine/dynamic_form_fields#field_with_values', as: 'field_values'

  devise_for :users, :controllers => {:sessions => 'sessions', registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks"  }

  # devise_scope :user do
    patch "/confirm" => "confirmations#confirm"
  # end
  #devise_for :users, :path_prefix => 'auth'
  resources :users

  root 'home#home_page'

  get 'home/landing_page', to: 'home#landing_page'

end