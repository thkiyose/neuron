Rails.application.routes.draw do
  get 'user_relations/create'
  get 'user_relations/destroy'
  root to: "contributions#home"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :contributions, only:%i(show) do
    collection do
      get :top
      get :home
      get :news
    end
  end
  resources :posts, only:%i(create)
  resources :profiles, only:%i(show edit update)
  resources :user_relations, only: %i(create destroy)
end
