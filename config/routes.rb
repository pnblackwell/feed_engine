require 'resque/server'

FeedEngine::Application.routes.draw do
  mount Resque::Server, at: "/resque"

  match '/', to: 'feeds#show', constraints: lambda { |r| warn "Route #{r.inspect}"; r.subdomain.present? && r.subdomain != 'www'}
  get  "/dashboard" =>"users#show", :as => 'dashboard'

  resources :feeds do
    resources :searches
  end

  resources :sessions
  resources :users, only: [:new, :create, :edit, :update]

  root to: 'sessions#home'


  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
