Rails.application.routes.draw do
  root  'home#index'
  get 'users/index' => "users#index"
  get "signup" => "users#new"
  get "users/:id" => "users#show"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get 'posts/index' => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create" 
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  get '/home' => "home#index"
  get '/about' => "home#about"
end
