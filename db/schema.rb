# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130519030102) do

  create_table "feed_items", :force => true do |t|
    t.string  "photo_url"
    t.string  "source",      :default => "flickr"
    t.integer "feed_id"
    t.string  "photo_title"
    t.string  "owner"
    t.integer "search_id"
  end

  add_index "feed_items", ["feed_id"], :name => "index_feed_items_on_feed_id"
  add_index "feed_items", ["search_id"], :name => "index_feed_items_on_search_id"

  create_table "feeds", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "subdomain",  :null => false
  end

  add_index "feeds", ["user_id"], :name => "index_feeds_on_user_id"

  create_table "searches", :force => true do |t|
    t.string  "search_type"
    t.string  "value"
    t.integer "feed_id"
    t.string  "source",      :default => "flickr"
  end

  add_index "searches", ["feed_id"], :name => "index_searches_on_feed_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "provider_id"
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
