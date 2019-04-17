Rails.application.routes.draw do

  resources :leaderboards
  resources :scores
  get 'player/index'

  resources :options
  resources :questions
  resources :subgenres
  resources :genres

  get 'admin/index'
  get 'sessions/create'
  get 'sessions/destroy'
  #get 'sessions/new'
  resources :users

  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end
  root 'sessions#new'
  #root 'admin#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
