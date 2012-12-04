class Downloader::CategoriesController < InheritedResources::Base
  def index
    @downloader_categories = Downloader::Category.all
  end
end
