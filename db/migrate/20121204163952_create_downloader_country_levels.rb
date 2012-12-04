class CreateDownloaderCountryLevels < ActiveRecord::Migration
  def change
    create_table :downloader_country_levels do |t|
      t.references :downloader_category
      t.string :name
      t.text :url
      t.references :downloader_category_content
      t.string :xpath

      t.timestamps
    end
  end
end
