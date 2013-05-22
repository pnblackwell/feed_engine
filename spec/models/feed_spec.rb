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
end
