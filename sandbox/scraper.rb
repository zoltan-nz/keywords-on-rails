require 'open-uri'
require 'mechanize'
require 'pp'
require 'csv'
require 'mysql2'
require 'benchmark'

begin

# @param [keyword] keyword
  def check(keyword)
    website_url = URI::encode("http://www.google.com/search?q=#{keyword}")
    agent = Mechanize.new
    page = agent.get(website_url)
    #pp page
    check = page.links.to_s.include?('skillpages')
    check
  end

  con = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => '', :database => 'keywords')

  con.query("SELECT * FROM keyword_stat WHERE topten = 0").each do |row|
    id = row["id"]
    result = check(row["keyword"])
    puts "#{id}. #{row["keyword"]} ==> #{result}"
    query_string = "UPDATE keyword_stat SET intopten = '#{result}', topten = '1' WHERE id LIKE '#{id}'"
    con.query(query_string)
  end

rescue Mysql2::Error => e
  puts e.errno
  puts e.error

ensure
  con.close if con

end