class Downloader::CountryLevelsController < InheritedResources::Base
  def index
    @downloader_country_levels = Downloader::CountryLevel.all
  end

  def download
    @downloader_country_level = Downloader::CountryLevel.find(params[:id])
    states = Downloader.country_level_downloader(@downloader_country_level)
    pp states
    redirect_to downloader_country_levels_path, notice: "Data updated"
  end
end
