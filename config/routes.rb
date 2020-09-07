Rails.application.routes.draw do
  root to: "contributions#index"
  resources :contributions do
    collection do
      get :top
    end
  end
end
