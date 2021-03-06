require 'nokogiri'
require 'mechanize'
require 'pp'
require 'open-uri'
require 'csv'

# --------- MAIN Country Website scraping --------------
# Collect urls to states data

#mainwebsite = "http://www.citypopulation.de/USA.html"
#
#agent = Mechanize.new
#page = agent.get(mainwebsite)
#
#states = []
#
#table = page.search("table[class='select'] tr a")
#
#table.each do |node|
#  if node['href'].include? 'census'
#    states << [node['href'], node.content]
#  end
#end
#
#csv = CSV.open("states.csv", "wb")
#
#states.each do |v|
#  csv << v
#end
#csv.close

# ------ Processing state websites -------------

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


csv = CSV.open("all-cities-ie.csv", "wb", "r:UTF-8")
#states.each do |state|
download_cities("php/ireland.php").each do |row|
  result = [row[0], row[1], row[2]]
  csv << result
end

download_cities("php/ireland-dublin.php").each do |row|
  result = [row[0], row[1], row[2]]
  csv << result
end
csv.close


#pp download_cities("php/usa-census-kansas.php")[1]