require 'spec_helper'

describe Feed do
  describe '#collect_feed_items' do
    context 'with only one search and one source' do
      it "generates feeds items & saves them to the db" do
        #THIS TEST NEEDS VCR OR A STUB FOR THE API
        feed = Feed.new(name: 'kittens', subdomain: "kittens")
        search = feed.searches.new(search_type: 'username', value: 'jcasimir')
        feed.save
        feed.collect_feed_items

        expect(feed.feed_items.first.feed_id).to eq(feed.id)
      end
    end

    context 'with two searches and one source' do
      it "generates feeds items & saves them to the db" do
        #THIS TEST NEEDS VCR OR A STUB FOR THE API
        feed = Feed.new(name: 'kittens', subdomain: "kittens")
        search1 = feed.searches.new(search_type: 'username', value: 'jcasimir')
        search2 = feed.searches.new(search_type: 'username', value: '-hndrk-')
        feed.save
        feed.collect_feed_items

        expect(feed.feed_items.first.feed_id).to eq(feed.id)
        expect(feed.feed_items.first.search_id).to eq(search1.id)
        expect(feed.feed_items.last.search_id).to eq(search2.id)
      end
    end
  end

  describe 'validation' do
    it 'doesnt allow two subdomains with the same name to be created' do
      pending
      feed1 = Feed.new(name: 'feed1', subdomain: 'feed')
      search = feed1.searches.new(search_type: 'username', value: 'jcasimir')
      feed2 = Feed.new(name: 'feed2', subdomain: 'feed')

      expect(feed2).to be_invalid
    end
  end
end
