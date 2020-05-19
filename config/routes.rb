require 'sidekiq/web'
Rails.application.routes.draw do
  get 'notifications/index'
  get 'assets/index'
  devise_for :users
  get 'users/:id', to: 'users#show', as: 'show_user'
  delete 'delete_profile_picture', to: 'users#delete_profile_picture', as: 'delete_profile_picture'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :assets do
    resources :bookings do
      collection do
        post :create_request
        get :new_request
      end
    end
    collection do
      get :sort_and_filter_assets
    end
    resources :ratings, only: [:index, :create, :edit, :destroy]
    get :add_to_wishlist
    delete :remove_from_wishlist
  end
  get 'wished_assets', to: 'assets#wished_assets', as: 'wished_assets'
  resources :bookings, only: [:index, :destroy] do
    collection do
      get :requests
      get 'show_request/:id', to: 'bookings#show_request', as: 'show_request'
      get :my_requests_index
      get 'show_request/:request_id/reject_request', to: 'bookings#reject_request', as: 'reject_request'
      get 'show_request/:request_id/accept_request', to: 'bookings#accept_request', as: 'accept_request'
      get :booked_assets
    end
  end
  resources :notes, path: 'notes/:request_id', only: [:create, :index, :destroy]

  get 'myassets', to: 'users#index_of_assets', as: 'my_assets'
  get 'search_option', to: 'assets#get_option_for_search_input', as: 'search_option'
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

  match '*path', to: "application#render_404", via: :all, constraints: lambda {|req| req.path.exclude? 'rails/active_storage'}
end
