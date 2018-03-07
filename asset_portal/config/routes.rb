Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
  mathjax 'mathjax'


  resources :authors
  resources :articles
    get 'article/get_pagination_splines', to: 'articles#get_pagination_splines', as: :get_article_pagination_splines
  resources :users
  resources :raw_articles
    get 'raw_article/get_pagination_splines', to: 'raw_articles#get_pagination_splines', as: :get_raw_article_pagination_splines
    post '/curate', to: 'raw_articles#curate', as: :curate



  get '/import', to: 'users#import', as: :import
  post '/parse_import', to: 'users#parse_import', as: :parse_import

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
