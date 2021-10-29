Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get "home/about" => "homes#about"
  get "users/timeline" => "users#timeline"
  get 'search' => 'searches#search'
  get '/recipe/hashtag/:name' => "recipes#index", as: 'hashtag_search'
  # get '/recipe/hashtag/:name' => "recipes#hashtag", as:'hashtag_search'
  # get '/recipes/:name' => "recipes#index", as:'hashtag_search'
  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  resources :recipes do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
end
