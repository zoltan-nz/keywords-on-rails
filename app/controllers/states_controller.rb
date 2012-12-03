class StatesController < ApplicationController
  # GET /states
  # GET /states.json
  def index
    @states = State.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @states }
    end
  end

  # GET /states/1
  # GET /states/1.json
  def show
    @state = State.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @state }
    end
  end

  # GET /states/new
  # GET /states/new.json
  def new
    @state = State.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @state }
    end
  end

  # GET /states/1/edit
  def edit
    @state = State.find(params[:id])
  end

  # POST /states
  # POST /states.json
  def create
    @state = State.new(params[:state])

    respond_to do |format|
      if @state.save
        format.html { redirect_to @state, notice: 'State was successfully created.' }
        format.json { render json: @state, status: :created, location: @state }
      else
        format.html { render action: "new" }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /states/1
  # PUT /states/1.json
  def update
    @state = State.find(params[:id])

    respond_to do |format|
      if @state.update_attributes(params[:state])
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state = State.find(params[:id])
    @state.destroy

    respond_to do |format|
      format.html { redirect_to states_url }
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
        state = State.build_from_csv(row)
        if state.valid?
          state.save
        else
          errs << row
        end
      end

      if errs.any?
        errFile = "errors_#{Date.today.strftime('%d%b%y')}.csv"
        errs.insert(0, State.csv_header)
        #pp errs
        errCSV = CSV.generate do |csv|
          errs.each {|row| csv << row}
        end
        send_data errCSV,
                  :type => 'text/csv; charset=iso-8859-1; header=present',
                  :disposition => "attachment; filename=#{errFile}"
      else
        flash[:notice] = t('state.import.successful')
        redirect_to country_import_url
      end
    end
  end
end

