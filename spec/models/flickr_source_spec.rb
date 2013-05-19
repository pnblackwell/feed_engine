require 'spec_helper'

describe FlickrSource do
  describe '#reject_existing_photos' do
    it 'returns a list of only new photos' do
      flickrsource = FlickrSource.new
      item1 = FeedItem.create(feed_id: 1, search_id: 1, source_id: 42)
      item2 = FeedItem.create(feed_id: 1, search_id: 1, source_id: 25)

      cleaned_list = [
            { photo_url: "http://farm7.staticflickr.com/6060/6335473183_d07e47ec51.jpg",
              owner: "69341872@N00", photo_title: "",
              source_id: 6335473183, source: 'flickr' },
            { photo_url: "http://farm3.staticflickr.com/2002/5738180053_78e25a82de.jpg",
              owner: "69341872@N00", photo_title: "IMG_0962",
              source_id: 5738180053, source: 'flickr'},
            { photo_url: "http://farm3.staticflickr.com/6/42_d1.jpg",
              owner: "69341872@N00", photo_title: "",
              source_id: 42, source: 'flickr'},
            { photo_url: "http://farm7.staticflickr.com/6/25_d1.jpg",
              owner: "69341872@N00", photo_title: "what",
              source_id: 25, source: 'flickr'}
                      ]
      results = flickrsource.reject_existing_photos(1, cleaned_list)
      expect(results.count).to eq(2)
      expect(results.first[:source_id]).to eq(6335473183)
    end
  end
end
