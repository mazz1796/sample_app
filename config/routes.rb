SampleApp::Application.routes.draw do
  root "static_pages#home"

  get "users/new"
  
  match '/signup', to: 'users#new', via: 'get'
  # match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  get '/help', to: "static_pages#help", as: "help"
  
  # get "static_pages/home"
  # get "static_pages/help"
  # get "static_pages/about"
  # get "static_pages/contact"


end
