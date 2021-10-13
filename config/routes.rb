Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get "home/about" => "homes#about"
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :followers, on: :member
    get :followeds, on: :member
  end
  resources :recipes do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
end
