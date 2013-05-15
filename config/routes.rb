FeedEngine::Application.routes.draw do

  match '', to: 'feeds#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www'}

  resources :sessions
  resources :feeds do
    resources :searches
  end

  root to: 'searches#show'


  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
