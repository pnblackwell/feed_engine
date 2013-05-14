FeedEngine::Application.routes.draw do

  root to: 'searches#show'

  resources :feeds do
    resources :searches
  end

  resources :sessions


  match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
