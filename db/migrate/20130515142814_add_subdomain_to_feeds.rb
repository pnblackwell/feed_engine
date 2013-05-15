class AddSubdomainToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :subdomain, :string, :null => false
  end
end
