Rails.application.config.middleware.use OmniAuth::Builder do
  provider :flickr, '8e2204133cf60f2cfb151c753163c5a6', 'c82a20016731f664'
end