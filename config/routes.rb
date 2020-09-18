Rails.application.routes.draw do
  devise_for :users
  # , skip: :all
  
  # devise_scope :user do
  #   get 'signup', to: 'devise/registrations#new'
  #   post 'signup', to: 'devise/registrations#create'
  #   get 'login', to: 'users/sessions#new'
  #   post 'login', to: 'users/sessions#create'
  #   delete 'logout', to: 'devise/sessions#destroy'
  #   get 'passwordedit', to: 'devise/passwords#edit'
  #   put 'passwordedit', to: 'devise/passwords#update'
  # end
  
  root 'index#home'
  get    '/terms',  to: 'index#terms'
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:new, :create, :destroy]
end
