FeedEngine::Application.routes.draw do
  root to: 'searches#show'

  # resource :search
  resources :feeds
  resources :sessions


  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'


end
