FeedEngine::Application.routes.draw do
  root to: 'searches#show'

  resources :feeds
end
  