Rails.application.routes.draw do
  devise_for :users
  root to: "contributions#index"
  resources :contributions do
    collection do
      get :top
    end
  end
end
