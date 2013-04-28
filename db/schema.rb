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

ActiveRecord::Schema.define(:version => 20121221164300) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "shortcode"
    t.integer  "googlecode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "downloader_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "downloader_country_levels", :force => true do |t|
    t.integer  "downloader_category_id"
    t.string   "name"
    t.text     "url"
    t.integer  "downloader_category_content_id"
    t.string   "xpath"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "downloader_state_levels", :force => true do |t|
    t.integer  "downloader_category_id"
    t.integer  "downloader_country_level_id"
    t.string   "name"
    t.text     "url"
    t.string   "xpath"
    t.integer  "downloader_content_category_id"
    t.integer  "column_contains_counties"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "geonames", :force => true do |t|
    t.integer  "geonameid"
    t.string   "name"
    t.string   "asciiname"
    t.string   "alternatenames"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "feature_class"
    t.string   "feature_code"
    t.string   "country_code"
    t.string   "cc2"
    t.string   "admin1_code"
    t.string   "admin2_code"
    t.string   "admin3_code"
    t.string   "admin4_code"
    t.integer  "population"
    t.integer  "elevation"
    t.integer  "dem"
    t.string   "timezone"
    t.date     "modification_date"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "scrapers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "targetdatabase"
    t.text     "websitecontent"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "capital"
    t.string   "name"
    t.string   "shortname"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "states", ["country_id"], :name => "index_states_on_country_id"

end
