class Downloader::Category < ActiveRecord::Base
  has_many :downloader_country_levels, :class_name => 'Downloader::CountryLevel'
  has_many :downloader_country_levels, :class_name => 'Downloader::CountryLevel'
  has_many :downloader_state_levels, :class_name => 'Downloader::StateLevel'

  attr_accessible :name, :downloader_country_levels, :downloader_state_levels
end
