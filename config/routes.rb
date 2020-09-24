Rails.application.routes.draw do
  root to: "contributions#home"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :contributions, only:%i(destroy show) do
    resources :comments, only: %i(create)
    collection do
      get :top
      get :home
      get :news
    end
  end
  resources :posts, only:%i(create edit update)
  resources :profiles, only:%i(show edit update)
  resources :user_relations, only: %i(create destroy) do
    member do
      get :show_following
      get :show_followers
    end
  end
  resources :favorites, only: %i(create destroy) do
    member do
      get :show_favorites
      get :show_favorited_by
    end
  end
end
