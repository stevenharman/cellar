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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131116001407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "availabilities", force: true do |t|
    t.integer "brewery_db_id", null: false
    t.string  "name",          null: false
    t.string  "description"
  end

  add_index "availabilities", ["brewery_db_id"], name: "index_availabilities_on_brewery_db_id", unique: true, using: :btree
  add_index "availabilities", ["name"], name: "index_availabilities_on_name", unique: true, using: :btree

  create_table "beers", force: true do |t|
    t.date     "best_by"
    t.integer  "brew_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "status",     default: "cellared"
    t.text     "notes"
    t.integer  "vintage"
    t.integer  "size_id"
  end

  add_index "beers", ["brew_id"], name: "index_beers_on_brew_id", using: :btree
  add_index "beers", ["size_id"], name: "index_beers_on_size_id", using: :btree
  add_index "beers", ["status"], name: "index_beers_on_status", using: :btree
  add_index "beers", ["user_id"], name: "index_beers_on_user_id", using: :btree

  create_table "breweries", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brewery_db_id",                         null: false
    t.text     "description"
    t.date     "established"
    t.boolean  "organic"
    t.text     "images"
    t.string   "brewery_db_status", default: "unknown", null: false
  end

  add_index "breweries", ["brewery_db_id"], name: "index_breweries_on_brewery_db_id", unique: true, using: :btree
  add_index "breweries", ["brewery_db_status"], name: "index_breweries_on_brewery_db_status", using: :btree

  create_table "brewery_brews", force: true do |t|
    t.integer  "brewery_id", null: false
    t.integer  "brew_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "brewery_brews", ["brew_id"], name: "index_brewery_brews_on_brew_id", using: :btree
  add_index "brewery_brews", ["brewery_id", "brew_id"], name: "index_brewery_brews_on_brewery_id_brew_id", unique: true, using: :btree

  create_table "brews", force: true do |t|
    t.string   "name"
    t.decimal  "abv",                  precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.decimal  "ibu",                  precision: 5, scale: 2
    t.string   "brewery_db_id",                                                    null: false
    t.integer  "style_id"
    t.text     "labels"
    t.date     "year"
    t.boolean  "organic"
    t.string   "base_brew_id"
    t.decimal  "original_gravity"
    t.integer  "cellared_beers_count",                         default: 0,         null: false
    t.string   "brewery_db_status",                            default: "unknown", null: false
    t.integer  "availability_id"
  end

  add_index "brews", ["availability_id"], name: "index_brews_on_availability_id", using: :btree
  add_index "brews", ["brewery_db_id"], name: "index_brews_on_brewery_db_id", unique: true, using: :btree
  add_index "brews", ["brewery_db_status"], name: "index_brews_on_brewery_db_status", using: :btree
  add_index "brews", ["style_id"], name: "index_brews_on_style_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name",          null: false
    t.integer  "brewery_db_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "categories", ["brewery_db_id"], name: "index_categories_on_brewery_db_id", unique: true, using: :btree
  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "import_candidate_beers", force: true do |t|
    t.integer "import_ledger_id"
    t.integer "brew_id"
    t.string  "confidence"
    t.integer "count",            default: 1, null: false
    t.date    "best_by"
    t.integer "line_number",      default: 0, null: false
    t.text    "notes"
    t.integer "size_id"
    t.integer "vintage"
    t.hstore  "source_row"
  end

  add_index "import_candidate_beers", ["import_ledger_id"], name: "index_import_candidate_beers_on_import_ledger_id", using: :btree

  create_table "import_ledgers", force: true do |t|
    t.integer  "user_id"
    t.string   "csv_file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "match_order_status", default: "new", null: false
  end

  add_index "import_ledgers", ["user_id"], name: "index_import_ledgers_on_user_id", unique: true, using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: true do |t|
    t.integer "brewery_db_id"
    t.string  "measure",       null: false
    t.string  "quantity"
    t.string  "name"
  end

  add_index "sizes", ["brewery_db_id"], name: "index_sizes_on_brewery_db_id", using: :btree

  create_table "styles", force: true do |t|
    t.string   "name",          null: false
    t.integer  "brewery_db_id", null: false
    t.integer  "category_id",   null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "description"
  end

  add_index "styles", ["brewery_db_id"], name: "index_styles_on_brewery_db_id", unique: true, using: :btree
  add_index "styles", ["category_id"], name: "index_styles_on_category_id", using: :btree
  add_index "styles", ["name"], name: "index_styles_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                               null: false
    t.string   "email",                  default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.text     "bio"
    t.string   "website"
    t.string   "location"
    t.string   "name"
    t.boolean  "staff",                  default: false, null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["staff"], name: "index_users_on_staff", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
