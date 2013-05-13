require 'spec_helper'

describe Feed do
  describe '#generate_feed_items' do
    it "generates feeds items & saves them to the db" do
      kittens = Feed.new(name: 'kittens')
      search = kittens.searches.new(search_type: 'username', value: 'jcasimir')
      kittens.save

      kitten_feed_items = kittens.generate_feed_items
      puts "WHATTTTT #{kittens.feed_items.inspect}"
      puts "kitten_feed_items #{kitten_feed_items}"
      expect(kittens.feed_items).to eq kitten_feed_items
      

      # expect(kittens.feed_items).to eq 3
      # expect(kittens.feed_items.first.feed_id) to eq kittens.id

      kittens.feed_items.each do |feed_item|
        expect(feed_item.feed_id).to eq kittens.id
      end
    end
  end

end
