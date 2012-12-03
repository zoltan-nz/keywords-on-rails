require 'rubygems'
require 'open-uri'
require 'mechanize'
gem 'activerecord'
require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'mechanize.db'
)

class Scraper < ActiveRecord::Base
  has_many :lines
end

class Line < ActiveRecord::Base
  belongs_to :websites
end

unless Scraper.table_exists?

  ActiveRecord::Schema.define(:version => 20121202114400) do

    create_table "scrapers", :force => true do |t|
      t.string   "name"
      t.string   "url"
      t.string   "targetdatabase"
      t.text     "websitecontent"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end

    create_table "lines", :force => true do |t|
      t.text     "name"
      t.text     "content"
      t.integer  "scraper_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "lines", ["scraper_id"], :name => "index_lines_on_scraper_id"

  end

end