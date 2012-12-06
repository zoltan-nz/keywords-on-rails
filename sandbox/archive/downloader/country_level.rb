class Downloader::CountryLevel < ActiveRecord::Base
  belongs_to :downloader_category, :class_name => 'Downloader::Category', :foreign_key => 'downloader_category_id'
  belongs_to :downloader_category_content, :class_name => 'Downloader::Category', :foreign_key => 'downloader_category_content_id'

  attr_accessible :name, :url, :xpath, :downloader_category_content_id, :downloader_category_id
end
