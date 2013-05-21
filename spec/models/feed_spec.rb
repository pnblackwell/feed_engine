require 'spec_helper'

describe Feed do
  describe '#collect_feed_items' do
    context 'with only one search and one source' do
      it "generates feeds items & saves them to the db" do
        #THIS TEST NEEDS VCR OR A STUB FOR THE API
        feed = Feed.new(name: 'kittens', subdomain: "kittens")
        search = feed.searches.new(search_type: 'username', value: 'jcasimir', source: 'flickr')
        feed.save
        feed.collect_feed_items

        expect(feed.feed_items.first.feed_id).to eq(feed.id)
      end

      it 'creates search object' do
        feed = described_class.new(name: 'j3', subdomain: 'j3', search_type: 'username', value: 'jcasimir', sources: ['flickr'])
        feed.save!
        feed.searches.count.should eq 1
      end
    end

    context 'with two sources' do
      it 'creates two search objects' do
        feed = described_class.new(name: 'j3', subdomain: 'j3', search_type: 'username', value: 'jcasimir', sources: ['flickr', '500px'])
        feed.save!
        feed.searches.count.should eq 2
      end
    end

    context 'with two searches and one source' do
      it "generates feeds items & saves them to the db" do
        #THIS TEST NEEDS VCR OR A STUB FOR THE API
        feed = Feed.new(name: 'kittens', subdomain: "kittens")
        search1 = feed.searches.new(search_type: 'username', value: 'jcasimir', source: 'flickr')
        search2 = feed.searches.new(search_type: 'username', value: '-hndrk-', source: 'flickr')

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

  describe 'validation' do
    it 'doesnt allow two feeds with the same subdomain name to be created' do
      feed1 = Feed.create(name: 'feed1', subdomain: 'feed')
      feed2 = Feed.new(name: 'feed2', subdomain: 'feed')

      expect(feed2).to be_invalid
    end

    it 'doesnt allow two feeds with the same name to be created' do
      feed1 = Feed.create(name: 'feed', subdomain: 'feed1')
      feed2 = Feed.create(name: 'feed', subdomain: 'feed2')

      expect(feed2).to be_invalid
    end

    it 'cleans up subdomains with parameterize' do
      feed1 = Feed.create(name: 'feed', subdomain: 'i-really-really-like-feeds')

      expect(feed1).to be_invalid
    end
  end
end
