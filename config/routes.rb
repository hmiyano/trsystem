Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'te_signup', to: 'trainees#new'
  get 'tr_signup', to: 'trainers#new'
  
  resources :trainees, only: [:show, :new, :create]
  resources :trainers, only: [:show, :new, :create]
  
end
