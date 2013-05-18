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

  def get_username_photos(username)
    id = get_user_id(username)
    photos_list = flickr.photos.search(api_key: FlickRaw.api_key, user_id: id)
    cleaned_list = Flickr.clean_results(photos_list)
  end

  def self.clean_results(results)
    clean_list = results.collect do |result|
                { source: 'flickr',
                  photo_title: result['title'],
                  owner: result['owner'],
                  photo_url: "http://farm#{result['farm']}.staticflickr.com/#{result['server']}/#{result['id']}_#{result['secret']}.jpg"
                }
              end
    clean_list
  end

  def get_user_id(username)
    flickr.people.findByUsername(username: username).id
  end
end
