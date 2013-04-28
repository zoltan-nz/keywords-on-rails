require 'zip/zip'
require 'zip/zip_input_stream'
require 'zip/zipfilesystem'
require 'open-uri'
require 'pp'

country_code = "US"
EXPORT_HEADERS = %W(country_code postal_code place_name admin_name1 admin_code1 admin_name2 admin_code2 admin_name3 admin_code3 latitude longitude accuracy)

#zip_data = open("http://download.geonames.org/export/zip/US.zip") { |f| f.binmode; f.read }
zip_data = open("http://download.geonames.org/export/zip/US.zip")
#pp zip_data
stream = lambda { return zip_data.slice!(0, 256) }
csv = EXPORT_HEADERS.join("\t") + "\n"
#Zip::Archive.open_buffer(stream) do |archive|
Zip::ZipFileSystem.open(zip_data) do |archive|

  pp archive


  sleep(30)

  #csv << f.read if f.name =~ /\A#{country_code}/

end
#pp csv


