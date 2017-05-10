Rails.application.routes.draw do
  
  # Routes for main resources
  resources :items
  resources :purchases
  resources :item_prices
  resources :users
  resources :sessions
  resources :schools
  resources :orders
  resources :cart #do
  #   get :add_to_cart, on :user
 

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  #authentication routes
  get 'user/edit' => 'users#edit', as: :edit_current_user
  get 'signup' => 'users#new', as: :signup
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login

  #orderitem
  get 'order_item/:id/ship' => 'order_items#ship', as: :ship

  #cart stuff
  get 'item/:id/addtocart' => 'items#addtocart', as: :addtocart
  get 'item/:id/removefromcart' => 'items#removefromcart', as: :removefromcart
  get 'clearcart' => 'cart#clearcart', as: :clearcart
  get 'yourcart' => 'cart#index', as: :yourcart
  get 'savecart' => 'order#savecart', as: :savecart
  
  # Set the root url
  root :to => 'home#home'  

end
