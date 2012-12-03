class Country < ActiveRecord::Base
  has_many :states
  attr_accessible :shortcode, :googlecode, :name

  validates_presence_of :shortcode, :googlecode, :name

  def self.csv_header
  	"Name,Short Code,Google Code".split(',')
  end

  def self.build_from_csv(row)
  	cou = find_or_initialize_by_name(row[0])
  	cou.attributes = {
  		:name => row[0],
  		:shortcode => row[1],
  		:googlecode => row[2]
  	}
  	return cou
  end

  def to_csv
  	[name, shortcode, google_code]
  end


end
