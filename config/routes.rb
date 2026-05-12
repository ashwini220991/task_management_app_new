Rails.application.routes.draw do
  devise_for :users, sign_out_via: :get

  authenticated :user do
    root 'tasks#index', as: :authenticated_root
  end

  unauthenticated do
    root 'home#index'
  end

  resources :tasks do
    member do
      patch :mark_complete
    end
  end

  namespace :api do
    namespace :v1 do
      post 'largest_submatrix', to: 'matrices#largest_submatrix'
    end
  end
end
