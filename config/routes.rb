Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users

    root to: "users#index"
  end

  root to: "tasks#index"
  resources :tasks
  get '*anything', to: "application#rescue404"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
