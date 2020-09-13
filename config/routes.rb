Rails.application.routes.draw do
  root to: "contributions#index"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :contributions, only:%i(show) do
    collection do
      get :top
    end
  end
end
