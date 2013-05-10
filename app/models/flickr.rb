class Flickr
attr_reader :username

  FlickRaw.api_key = '8e2204133cf60f2cfb151c753163c5a6'
  FlickRaw.shared_secret = 'c82a20016731f664'

  def initialize(username)
    @username = username
  end

  def get_photos
    id = get_user_id
    flickr.photos.search(api_key: FlickRaw.api_key, user_id: id)
  end

  def get_user_id
    flickr.people.findByUsername(username: username).id 
  end
end