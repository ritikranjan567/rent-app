Rails.application.routes.draw do
  get 'assets/index'
  devise_for :users
  delete 'deleteprofilepic', to: 'users#delete_profile_pic', as: 'delete_profile_pic'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :assets
  root 'assets#index'

  resources :phone_verifications, only: [:new, :create] do |p|
    collection do
      get 'challenge'
      post 'verify'
      get 'success'
    end
  end
end
