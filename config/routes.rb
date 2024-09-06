Rails.application.routes.draw do
  # get '/new', to: 'users#new'
  # get '/index', to: 'users#index'
  # post 'users' ,to: 'users#create' 
  # delete 'users/:id',to:'users#destroy', as: :user_delete 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users, only: [:index, :new, :create, :edit, :update , :patch,:destroy]
  root "users#new"
end
