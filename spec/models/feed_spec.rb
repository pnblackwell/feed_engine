require 'spec_helper'

describe Feed do
  describe '#generate_feed_items' do
    it "generates feeds items & saves them to the db" do
      kittens = Feed.new(name: 'kittens')
      search = kittens.searches.new(search_type: 'username', value: 'jcasimir')
      kittens.save

      kittens.feed_items.each do |feed_item|
        expect(feed_item.feed_id).to eq kittens.id
      end
    end
  end

end
