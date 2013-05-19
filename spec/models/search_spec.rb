require 'spec_helper'

describe Search do
  describe '#generate_feed_items' do
    it 'creates new feed items specific to the search and feed' do
      search = Search.new( search_type: 'username', value: '-hndrk-')
      search.feed_id = 1
      search.save
      search.generate_feed_items

      first_return = search.feed_items.first

      expect(first_return.search_id).to eq(search.id)
      expect(first_return.feed_id).to eq(1)
    end
  end
end
