module Downloader
  def self.table_name_prefix
    'downloader_'
  end

  # Input: downloader_country_level model, Output: table content in array
  # @param [CountryLevel] country
  # @return [Array]
  def self.country_level_downloader(country)

    mainwebsite = country.url

    agent = Mechanize.new
    page = agent.get(mainwebsite)

    states = []

    table = page.search(country.xpath)
    pp "table = #{table}"
    table.each do |node|
      pp node.search['/href']
      if node['href'].value.include? 'census'
        states << [node['href'], node.content]
      end
    end

    states
  end

end
