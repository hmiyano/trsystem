Rails.application.routes.draw do
  root to: 'toppages#index'
  
  #トレーニーのログインセッション
  get 'te_login', to: 'te_sessions#new'
  post 'te_login', to: 'te_sessions#create'
  delete 'te_logout', to: 'te_sessions#destroy'

  #トレーナーのログインセッション
  get 'tr_login', to: 'tr_sessions#new'
  post 'tr_login', to: 'tr_sessions#create'
  delete 'tr_logout', to: 'tr_sessions#destroy'
  
  #管理者のログインセッション
  get 'admin_login', to: 'admin_sessions#new'
  post 'admin_login', to: 'admin_sessions#create'
  delete 'admin_logout', to: 'admin_sessions#destroy'

  get 'te_signup', to: 'trainees#new'
  get 'tr_signup', to: 'trainers#new'
  
  resources :trainees, only: [:show, :new, :create]
  resources :trainers, only: [:show, :new, :create]
  resources :checklists
  resources :te_checks, only: [:create, :destroy]
  resources :tr_checks, only: [:create, :destroy]
  resources :admins, only: [:show, :new, :create]
end
