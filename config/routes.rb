Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'te_login', to: 'te_sessions#new'
  post 'te_login', to: 'te_sessions#create'
  delete 'te_logout', to: 'te_sessions#destroy'

  get 'tr_login', to: 'tr_sessions#new'
  post 'tr_login', to: 'tr_sessions#create'
  delete 'tr_logout', to: 'tr_sessions#destroy'

  get 'te_signup', to: 'trainees#new'
  get 'tr_signup', to: 'trainers#new'
  
  resources :trainees, only: [:show, :new, :create]
  resources :trainers, only: [:show, :new, :create]
  
end
