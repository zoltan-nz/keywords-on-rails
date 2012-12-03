class State < ActiveRecord::Base
  belongs_to :country
  attr_accessible :capital, :name, :shortname, :country, :country_id

  validates_presence_of :capital, :name, :shortname

  def self.csv_header
    "country_id,capital,name,shortname".split(',')
  end

  def self.build_from_csv(row)
    st = find_or_initialize_by_name(row[0])
    st.attributes = {
        :country_id => row[0],
        :capital => row[1],
        :name => row[2],
        :shortname => row[3]
    }
    return st
  end

  def to_csv
    [country,capital,name,shortname]
  end


end
