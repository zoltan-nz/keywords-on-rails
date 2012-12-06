class Downloader::StateLevel < ActiveRecord::Base
  belongs_to :downloader_category, :class_name => 'Downloader::Category', :foreign_key => 'downloader_category_id'
  belongs_to :downloader_category, :class_name => 'Downloader::Category', :foreign_key => 'downloader_category_content_id'
  belongs_to :downloader_country_level, :class_name => 'Downloader::CountryLevel', :foreign_key => 'downloader_country_level_id'

  attr_accessible :downloader_category, :column_contains_counties, :downloader_category_content, :downloader_country_level, :name, :url, :xpath
end
