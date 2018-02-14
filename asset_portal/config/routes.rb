Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'

  resources :authors
  resources :articles
  resources :users
  get '/import', to: 'users#import', as: :import
  post '/parse_import', to: 'users#parse_import', as: :parse_import
  get '/curate', to: 'articles#curate', as: :curate

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
