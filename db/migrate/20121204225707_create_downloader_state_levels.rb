class CreateDownloaderStateLevels < ActiveRecord::Migration
  def change
    create_table :downloader_state_levels do |t|
      t.references :downloader_category
      t.references :downloader_country_level
      t.string :name
      t.text :url
      t.string :xpath
      t.references :downloader_category_content
      t.integer :column_contains_counties

      t.timestamps
    end
  end
end
