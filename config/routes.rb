Rails.application.routes.draw do
  root to: "contributions#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :contributions, only:%i(index,show) do
    collection do
      get :top
    end
  end
end
