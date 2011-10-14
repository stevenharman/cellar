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

ActiveRecord::Schema.define(:version => 20111014145629) do

  create_table "beers", :force => true do |t|
    t.string   "batch"
    t.date     "born_on"
    t.date     "best_by"
    t.integer  "inventory",   :default => 0, :null => false
    t.text     "description"
    t.integer  "brew_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beers", ["brew_id"], :name => "index_beers_on_brew_id"

  create_table "breweries", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brews", :force => true do |t|
    t.string   "name"
    t.string   "series"
    t.decimal  "abv",        :precision => 5, :scale => 2
    t.integer  "brewery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brews", ["brewery_id"], :name => "index_brews_on_brewery_id"
  add_index "brews", ["name"], :name => "index_brews_on_name", :unique => true

end
