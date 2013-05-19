class Flickr
  attr_reader :search_type, :value

  FlickRaw.api_key       = ENV['FLICKR_API_KEY']
  FlickRaw.shared_secret = ENV['FLICKR_SECRET']

  def initialize(search)
    @search_type = search.search_type
    @value = search.value
  end

  def retrieve_photos
    send("get_#{search_type}_photos", value)
  end

  def get_keyword_photos(keyword)
    photos = flickr.photos.search(api_key: FlickRaw.api_key, tags: keyword, extras: 'owner_name', page: 1, per_page: 30)
    cleaned_list = Flickr.clean_results(photos)
  end

  def get_username_photos(username)
    # flickr.value?
    id = get_user_id(username)
    photos_list = flickr.photos.search(api_key: FlickRaw.api_key, user_id: id, extras: 'owner_name', page: 1, per_page: 30)
    cleaned_list = Flickr.clean_results(photos_list)
  end

  def self.get_username_from_id(user_id)
    flickr.people.getInfo(api_key: FlickRaw.api_key, url: user_id)['username']
  end

  def self.clean_results(results)
    #this method will need to change how we get owner once we start doing keyword searches
    clean_list = results.collect do |result|
                { source: 'flickr',
                  source_id: result['id'].to_i,
                  photo_title: result['title'],
                  owner: result['owner_name'],
                  photo_url: "http://farm#{result['farm']}.staticflickr.com/#{result['server']}/#{result['id']}_#{result['secret']}.jpg"
                }
              end
    clean_list
  end

  def get_user_id(username)
    flickr.people.findByUsername(username: username).id
  end
end
