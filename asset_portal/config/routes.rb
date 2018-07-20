Rails.application.routes.draw do
  resources :tag_groups
  # resources :roles
  # resources :tags
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
  mathjax 'mathjax'

  resources :articles
    get '/search', to: 'articles#search', as: :search
  resources :users
    get 'user/get_curated_articles_pagination_splines', to: 'users#get_user_curated_articles_pagination_splines', as: :get_user_curated_articles_pagination_splines
    get 'user/get_curated_articles', to: 'users#get_user_curated_articles', as: :get_user_curated_articles
  resources :raw_articles
    get 'raw_article/get_pagination_splines', to: 'raw_articles#get_pagination_splines', as: :get_raw_article_pagination_splines
    get 'raw_article/curate/:id', to: 'raw_articles#curate_raw_article', as: :curate_raw_article
    post '/curate', to: 'raw_articles#curate', as: :curate



  get '/import', to: 'users#import', as: :import
  post '/parse_import', to: 'users#parse_import', as: :parse_import

  get '/import_specific', to: 'users#import_specific', as: :import_specific
  post '/parse_import_specific', to: 'users#parse_import_specific', as: :parse_import_specific

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
