require 'nokogiri'
require 'mechanize'
require 'open-uri'

class Scraper < ActiveRecord::Base
  attr_accessible :name, :url, :targetdatabase, :websitecontent

  def self.websitedownloader(website)
    pp "This is websitedownloader"
    pp website
    website_url = website[:url]
    #agent = Mechanize.new
    #page = agent.get(website_url)
    page = Nokogiri::HTML(open(website_url))
    pp page
    return page
  end

end
