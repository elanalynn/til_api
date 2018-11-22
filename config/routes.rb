Rails.application.routes.draw do
  resources :items do
    resources :tags
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
