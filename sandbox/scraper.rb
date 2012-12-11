require 'open-uri'
require 'mechanize'
require 'pp'
require 'csv'
# require 'mysql2'
require 'benchmark'

begin

# @param [keyword] keyword
  def check(keyword)
    # website_url = URI::encode("http://www.google.com/search?q=#{keyword}")
    agent = Mechanize.new
    agent.user_agent_alias="Mac Safari"
    page = agent.get("http://www.google.com")
    google_form = page.forms[0]
    google_form.q = keyword
    page = agent.submit(google_form)
    agent.cookie_jar.clear!
    # pp page
    check = page.links.to_s.include?('skillpages')
  end

  #con = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => '', :database => 'keywords')

  #result = ""

  #  con.query("SELECT * FROM keyword_stat WHERE topten = '0'").each do |row|
  #    id = row["id"]
  #    time = Benchmark.measure do
  #      result = check(row["keyword"])
  #    end
  #    puts "Time of check: #{time}"
  #    puts "#{id}. #{row["keyword"]} ==> #{result}"
  #    query_string = "UPDATE keyword_stat SET intopten = '#{result}', topten = '1' WHERE id LIKE '#{id}'"
  #    time = Benchmark.measure do
  #      con.query(query_string)
  #    end
  #    puts "Time of query: #{time}"
  #  end
  #
  #rescue Mysql2::Error => e
  #  puts e.errno
  #  puts e.error
  #
  #ensure
  #  con.close if con
  i = 0
  resultscsv = CSV.open("../database/results.csv", "a")
  CSV.foreach(ARGV[0]) do |row|
    keyword = row[0]
    result = check(keyword)
    puts "#{i}. #{keyword} ==> #{result}"
    if result
      puts keyword
      resultscsv << [keyword]
    end
    i += 1
    puts i if i.modulo(500) == 0
  end
  puts i
  resultscsv.close

end