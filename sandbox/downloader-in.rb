require 'nokogiri'
require 'mechanize'
require 'pp'
require 'open-uri'
require 'csv'

#--------- MAIN Country Website scraping --------------
#Collect urls to states data

india = "http://www.citypopulation.de/India.html"

agent = Mechanize.new
page = agent.get(india)

states = []

table = page.search("div[class='mcol'] a")

table.each do |node|
  #if node['href'].include? 'census'
  states << [node['href'], node.content]
  #end
end

csv = CSV.open("states-india.csv", "wb")

states.each do |v|
  csv << v
end
csv.close

#------ Processing state websites -------------

def download_cities(url)

  subwebsite = "http://www.citypopulation.de/" + url
  agent = Mechanize.new
  page = agent.get(subwebsite)

  cells = []
  cities = []

  rows = page.search("table[id='ts'] tr")

  #p "rows length: #{rows.length}"
  #i = 0
  rows.each do |row|
    cells << row.search("td//text()").collect { |text| CGI.unescapeHTML(text.to_s.strip) }
    #p "Row: #{i}"
    #i = i + 1
  end

  #p cells[1][0..1].join(', ')

  cells.each do |cell|
    #unless cell[0].nil? || cell[0] == 0
    cities << [cell[0], cell[1], cell[2]]
    #end
  end

  return cities

end


csv = CSV.open("all-cities-in.csv", "wb",)
states.each do |state|
  download_cities(state[0]).each do |row|
    result = [row[0], row[1], row[2], state[1]]
    csv << result
  end
end

csv.close


#require 'iconv'
#
#utf8_csv = File.open("all-cities-in.csv").read
#
## gotta be careful with the weird parameters order: TO, FROM !
#ansi_csv = Iconv.iconv("LATIN1", "UTF-8", utf8_csv).join
#
#File.open("ansifile.csv", "w") { |f| f.puts ansi_csv }

