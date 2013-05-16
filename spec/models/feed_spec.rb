require 'spec_helper'

describe Feed do
  describe '#collect_feed_items' do
    it "generates feeds items & saves them to the db" do
      #THIS TEST NEEDS VCR OR A STUB FOR THE API
      kittens = Feed.new(name: 'kittens', subdomain: "kittens")
      search = kittens.searches.new(search_type: 'username', value: 'jcasimir')
      kittens.save
      kittens.collect_feed_items

      expect(kittens.feed_items.first.id).to eq(kittens.id)
    end
  end

end
