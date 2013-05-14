class AddSourceToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :source, :string, :default => 'flickr'
  end
end
