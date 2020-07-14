Rails.application.routes.draw do
  resources :articles
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :articles do
  	resource :comments, only: [:create, :destroy]
  end
  get '/top' => 'homes#top'
  get '/about' => 'homes#about'
  root 'homes#top'

  get '/search', to: 'searches#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
