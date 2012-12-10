require 'open-uri'
require 'mechanize'
require 'pp'

def check(keyword)
  website_url = URI::encode("http://www.google.com/search?q=#{keyword}")
  agent = Mechanize.new
  page = agent.get(website_url)
  #pp page
  pp page.links
end

check('tax specialist san francisco')