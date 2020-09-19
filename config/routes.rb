Rails.application.routes.draw do
  root to: "contributions#home"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :contributions, only:%i(index,show) do
    collection do
      get :top
      get :home
      get :news
    end
  end
  resources :posts, only:%i(create)
end
