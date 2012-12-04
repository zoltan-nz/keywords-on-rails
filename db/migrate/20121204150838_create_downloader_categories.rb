class CreateDownloaderCategories < ActiveRecord::Migration
  def change
    create_table :downloader_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
