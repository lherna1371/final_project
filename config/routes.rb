FinalProject::Application.routes.draw do
  get '/uploads/:dish_id', to: 'dishes#upload'
  post '/favorite/dish/:dish_id', to: 'users#favdish', as: "favorite"
  post '/favorite/restaurant/:rest_id', to: 'users#favrest'
  get '/users/:user_id/favorites', to: 'users#favorites'
  match 'auth/:provider/callback', to: 'sessions#createoauth', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  root 'landing#index'
  
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  resources :users

  get '/users/:user', to: 'users#show'
  
  resource :accounts, only: [:update]

  resources :sessions, only: [:create]
  get '/login',  to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'


  resources :restaurants do
    resources :dishes
  end
  post '/restaurants/create', to: 'restaurants#create'
  post '/restaurants/setcoords', to: 'restaurants#setcoords'
  get '/:restname', to: 'restaurants#show'
  get '/:restname/edit', to: 'restaurants#edit'
  get '/:restname/desc', to: 'restaurants#desc'
  get '/:restname/coords', to: 'restaurants#coords'
  

  get '/:restname/dishes', to: 'dishes#index'
  get '/:restname/dishes/new', to: 'dishes#new'
  get '/:restname/:dishname', to: 'dishes#show'
  get '/:restname/:dishname/edit', to: 'dishes#edit'
  post '/:restname/dishes', to: 'dishes#create'

  post '/:restname/:dishname', to: 'dishes#photo_new'
  
  resources :dishes, only: [:update, :destroy]
  resources :photos
  resources :comments
  

  post '/:restname/dishes/destroy', to: 'dishes#destroy'
  
  
  resources :dishes
  
end
