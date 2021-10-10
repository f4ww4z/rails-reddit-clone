Rails.application.routes.draw do
  devise_for :accounts
  get "u/:username" => "public#profile", as: :profile

  resources :communities do
    resources :posts
  end

  resources :subscriptions
  resources :comments, only: [:create]

  post "posts/vote" => "votes#create"

  root to: "public#index"
end
