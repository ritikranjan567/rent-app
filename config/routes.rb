require 'sidekiq/web'
Rails.application.routes.draw do
  get 'notifications/index'
  get 'assets/index'
  devise_for :users
  delete 'deleteprofilepic', to: 'users#delete_profile_pic', as: 'delete_profile_pic'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :assets do
    resources :bookings, only: [:create_request, :new_request] do
      collection do
        post :create_request
        get :new_request
      end
    end
    resources :ratings, only: [:index, :create, :edit, :destroy]
    get :add_to_wishlist
    delete :remove_from_wishlist
  end
  get 'wished_assets', to: 'assets#wished_assets', as: 'wished_assets'
  resources :bookings, only: [:index, :destroy] do
    collection do
      get :requests_index
      get 'show_request/:id', to: 'bookings#show_request', as: 'show_request'
      get :my_requests_index
      get 'show_request/:request_id/reject_request', to: 'bookings#reject_request', as: 'reject_request'
      get 'show_request/:request_id/accept_request', to: 'bookings#accept_request', as: 'accept_request'
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
