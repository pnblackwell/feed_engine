class AddSearchSourceToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :search_source, :string
  end
end
