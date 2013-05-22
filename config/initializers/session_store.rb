# Be sure to restart your server when you modify this file.
if Rails.env.development?
FeedEngine::Application.config.session_store :active_record_store
FeedEngine::Application.config.session_store :cookie_store, :key => '_tourlyapp_session', :domain => "lvh.me"
end


if Rails.env.production?
  FeedEngine::Application.config.session_store :active_record_store
  FeedEngine::Application.config.session_store :cookie_store, :key => '_tourlyapp_session', :domain => ".photoline-feed.us"
end


