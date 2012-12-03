require 'rubygems'
require 'open-uri'
require 'mechanize'
gem 'activerecord'
require 'sqlite3'
require 'active_record'
require 'nokogiri'

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'mechanize.db'
)

class Scraper < ActiveRecord::Base
  has_many :lines
  serialize :websitecontent, Hash

  def self.websitedownloader(website)
    #pp "This is websitedownloader"
    #pp website
    website_url = website[:url]
    agent = Mechanize.new
    page = agent.get(website_url)
    #page = Nokogiri::HTML(open(website_url))
    #pp page
    @lines = page.search('//body').children
    return @lines
  end

end

class Line < ActiveRecord::Base
  belongs_to :scraper

end

unless Scraper.table_exists?

  ActiveRecord::Schema.define(:version => 20121202114400) do

    create_table "scrapers", :force => true do |t|
      t.string "name"
      t.string "url"
      t.string "targetdatabase"
      t.text "websitecontent"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "lines", :force => true do |t|
      t.text "name"
      t.text "content"
      t.integer "scraper_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "lines", ["scraper_id"], :name => "index_lines_on_scraper_id"

  end

end

#agent = Mechanize.new
page = Nokogiri::HTML(open("test.html"))
pp page.length

#Scraper.find(1).websitecontent = page
#Scraper.find(1).save
#pp Scraper.find(1).websitecontent