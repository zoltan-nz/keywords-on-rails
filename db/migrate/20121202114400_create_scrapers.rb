class CreateScrapers < ActiveRecord::Migration
  def change
    create_table :scrapers do |t|
      t.string :name
      t.string :url
      t.string :xpath

      t.timestamps
    end
  end
end