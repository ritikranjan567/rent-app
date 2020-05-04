require 'sidekiq/web'
Rails.application.routes.draw do
  get 'notifications/index'
  get 'assets/index'
  devise_for :users
  delete 'deleteprofilepic', to: 'users#delete_profile_pic', as: 'delete_profile_pic'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :assets do
    resources :bookings do
      collection do
        post :create_request
        get :new_request
      end
    end
    #get 'bookings/newrequest', to: 'bookings#new_request', as: 'new_booking_request'
    #post 'bookings/requests', to: 'bookings#create_request', as: 'requests'
    resources :ratings, only: [:index, :create, :edit, :destroy]
  end
  #get 'bookings/requests_index', to: 'bookings#requests_index', as: 'requests_index'
  #get 'bookings/show_request/:id', to: 'bookings#show_request', as: 'show_request'
  resources :bookings do
    collection do
      get :requests_index
      get 'show_request/:id', to: 'bookings#show_request', as: 'show_request'
    end
  end

  resources :notes, path: 'notes/:request_id', only: [:create, :index, :destroy]

  get 'myassets', to: 'users#index_of_assets', as: 'my_assets'
  get 'searchoption', to: 'assets#get_option_for_search_input', as: 'search_option'
  root 'assets#index'

  resources :phone_verifications, only: [:new, :create] do |p|
    collection do
      get 'challenge'
      post 'verify'
      get 'success'
    end
  end

  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

  resources :notifications, only: [:index, :update]
end
