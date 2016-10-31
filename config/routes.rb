SampleApp::Application.routes.draw do

#####Adding following and followers actions to the Users controller.
  resources :users do
    member do
      get :following, :followers
    end
  end
#################################
 # resources :users #To get the REST-style URL to work by adding a single line to our routes file. Listing 7.3
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  root "static_pages#home"

  #get "users/new"

  match '/signup', to: 'users#new', via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  # match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  get '/help', to: "static_pages#help", as: "help"

  # get "static_pages/home"
  # get "static_pages/help"
  # get "static_pages/about"
  # get "static_pages/contact"

end
