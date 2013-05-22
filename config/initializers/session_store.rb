# Be sure to restart your server when you modify this file.
unless Rails.env.test?
FeedEngine::Application.config.session_store :active_record_store
FeedEngine::Application.config.session_store :cookie_store, :key => '_tourlyapp_session', :domain => "lvh.me"
end



