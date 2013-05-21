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

  describe 'deleting a feed' do
    it 'deletes corresponding searches' do
      feed1 = Feed.create(name: 'feed', subdomain: 'feed' )
      feed1.destroy

      expect(feed1.searches).to eq([])
    end

    it 'deletes corresponding feed_items' do
      feed1 = Feed.create(name: 'feed', subdomain: 'feed')
      feed1.destroy

      expect(feed1.feed_items).to eq([])
    end
  end

end
