require 'csv'
require 'pp'

class CountriesController < ApplicationController
  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country }
    end
  end

  # GET /countries/new
  # GET /countries/new.json
  def new
    @country = Country.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render json: @country, status: :created, location: @country }
      else
        format.html { render action: "new" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.json
  def update
    @country = Country.find(params[:id])

    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      format.html { redirect_to countries_url }
      format.json { head :no_content }
    end
  end

  def csvimport
    #return render :text => 'Itt vagyok a CSVimportban'
    #pp request


    if request.post? && params[:file].present?

      infile = params[:file].read
      n, errs = 0, []

      CSV.parse(infile) do |row|
        n +=1
        next if n == 1 or row.join.blank?
        country = Country.build_from_csv(row)
        if country.valid?
          country.save
        else
          errs << row
        end
      end

      if errs.any?
        errFile = "errors_#{Date.today.strftime('%d%b%y')}.csv"
        errs.insert(0, Country.csv_header)
        #pp errs
        errCSV = CSV.generate do |csv|
          errs.each {|row| csv << row}
        end
        send_data errCSV,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{errFile}"
        else
          flash[:notice] = t('country.import.successful')
          redirect_to country_import_url
        end
    end



    # respond_to do |format|
    #   if request.post? && params[:file].present?
    #     format.html { redirect_to country_import_path, :notice => "Successfully imported the CSV file."}# csvimport.html.erb
    #     format.json { render json: @country }
    #   else
    #     format.html
    #   end

    # end
  end

end
