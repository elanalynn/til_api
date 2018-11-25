Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :users do
      resources :items do
        resources :tags
      end
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'v1/users#create'
end
