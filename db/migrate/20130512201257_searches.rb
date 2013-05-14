class Searches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :search_type
      t.string :value
      t.references :feed
    end

    add_index :searches, :feed_id
  end
end
