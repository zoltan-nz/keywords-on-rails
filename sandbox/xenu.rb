require 'rubygems'
require 'open-uri'
require 'mechanize'
gem 'activerecord'
require 'sqlite3'
require 'active_record'
require 'nokogiri'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'xenu.db'
)

class Page

unless Xenu.table_exists?

  ActiveRecord::Schema.define(:version => 201301012218) do

    create_table "pages", :force => true do |t|
      t.string "name"
      t.string "url"
      t.string "title"
      t.string "description"
      t.string "h1"
      t.string "h2"
      t.string "h3"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "links", :force => true do |t|
      t.text "anchortext"
      t.text "url"
      t.text "nofollow"
      t.integer "page_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

  end

end