FeedEngine::Application.routes.draw do


  match '', to: 'feeds#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www'}

  resources :feeds do
    resources :searches
  end

  resources :sessions
  resources :users

  root to: 'sessions#home'


  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
