class CreateGeonames < ActiveRecord::Migration
  def change
    create_table :geonames do |t|
      t.integer  :geonameid
      t.string   :name
      t.string   :asciiname
      t.string   :alternatenames
      t.decimal  :latitude
      t.decimal  :longitude
      t.string   :feature_class
      t.string   :feature_code
      t.string   :country_code
      t.string   :cc2
      t.string   :admin1_code
      t.string   :admin2_code
      t.string   :admin3_code
      t.string   :admin4_code
      t.integer  :population
      t.integer  :elevation
      t.integer  :dem
      t.string   :timezone
      t.date     :modification_date

      t.timestamps
    end
  end
end