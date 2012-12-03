require 'nokogiri'
require 'mechanize'
require 'open-uri'

class Scraper < ActiveRecord::Base
  attr_accessible :name, :url, :targetdatabase, :websitecontent

  def self.websitedownloader(website)
    #pp "This is websitedownloader"
    #pp website
    website_url = website[:url]
    agent = Mechanize.new
    page = agent.get(website_url)
    #page = Nokogiri::HTML(open(website_url))
    #pp page
    @lines = page.search('//body').children.inject([]) do |lines_hash, child|
      name = child.name
      content = child.inner_text
      lines_hash << { :name => name, :content => content}
      lines_hash
    end
    return @lines
  end

end
