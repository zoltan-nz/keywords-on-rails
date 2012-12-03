class ScrapersController < ApplicationController
  def index
    @scrapers = Scraper.all
    @scraper = Scraper.new
  end

  def create
    @scraper = Scraper.new(params[:scraper])
    if @scraper.save
      redirect_to scrapers_path, notice: "Url was created."
    else
      render action: "index"
    end
  end

  def downloader
    pp "This is downloader"
    pp params
    @scraper = Scraper.find(params[:id])
    pp @scraper
    page = Scraper.websitedownloader(@scraper)
    @scraper.websitecontent = page
    @scraper.save
    redirect_to scrapers_path, notice: "Data updated"
  end
end
