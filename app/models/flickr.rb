class Flickr
  attr_reader :search_type, :value

  FlickRaw.api_key = '8e2204133cf60f2cfb151c753163c5a6'
  FlickRaw.shared_secret = 'c82a20016731f664'

  def initialize(search)
    @search_type = search.search_type
    @value = search.value
  end

  def retrieve_photos
    send("get_#{search_type}_photos", value)
  end

  def get_username_photos(username)
    id = get_user_id(username)
    flickr.photos.search(api_key: FlickRaw.api_key, user_id: id)
    #add a cleanup method here
    #photo url
    #owner (which should be the user id)
  end

  def get_user_id(username)
    flickr.people.findByUsername(username: username).id 
  end
end
