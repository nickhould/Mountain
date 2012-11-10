class DashboardsController < ApplicationController
  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = Dashboard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dashboards }
    end
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @dashboard = Dashboard.find(params[:id])
    ga = GoogleAnalytics.new
    #@visits = ga.per_day(:visits)
    @visits = fake_data 
    @visit_summary = ga.per_day(:visits)
    @sources = ga.profile.sources.sort_by{|e| e.visits.to_i}.reverse.take(10)
    @pages = top_pages
    @profiles = ga.profiles
    @web_properties = ga.web_properties
    



    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/new
  # GET /dashboards/new.json
  def new
    @dashboard = Dashboard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/1/edit
  def edit
    @dashboard = Dashboard.find(params[:id])
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(params[:dashboard])

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render json: @dashboard, status: :created, location: @dashboard }
      else
        format.html { render action: "new" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dashboards/1
  # PUT /dashboards/1.json
  def update
    @dashboard = Dashboard.find(params[:id])

    respond_to do |format|
      if @dashboard.update_attributes(params[:dashboard])
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard = Dashboard.find(params[:id])
    @dashboard.destroy

    respond_to do |format|
      format.html { redirect_to dashboards_url }
      format.json { head :no_content }
    end
  end

  private

  #Delete me in production
  def fake_data
    data = { "Fri, 09 Nov 2012"=>3, 
            "Thu, 08 Nov 2012"=>2, 
            "Wed, 07 Nov 2012"=>2, 
            "Tue, 06 Nov 2012"=>2, 
            "Mon, 05 Nov 2012"=>0, 
            "Sun, 04 Nov 2012"=>0, 
            "Sat, 03 Nov 2012"=>0, 
            "Fri, 02 Nov 2012"=>0, 
            "Thu, 01 Nov 2012"=>4, 
            "Wed, 31 Oct 2012"=>1, 
            "Tue, 30 Oct 2012"=>9, 
            "Mon, 29 Oct 2012"=>2, 
            "Sun, 28 Oct 2012"=>0, 
            "Sat, 27 Oct 2012"=>1, 
            "Fri, 26 Oct 2012"=>0, 
            "Thu, 25 Oct 2012"=>3, 
            "Wed, 24 Oct 2012"=>5, 
            "Tue, 23 Oct 2012"=>14, 
            "Mon, 22 Oct 2012"=>60, 
            "Sun, 21 Oct 2012"=>2, 
            "Sat, 20 Oct 2012"=>1, 
            "Fri, 19 Oct 2012"=>4, 
            "Thu, 18 Oct 2012"=>3, 
            "Wed, 17 Oct 2012"=>2, 
            "Tue, 16 Oct 2012"=>0, 
            "Mon, 15 Oct 2012"=>4, 
            "Sun, 14 Oct 2012"=>5, 
            "Sat, 13 Oct 2012"=>4, 
            "Fri, 12 Oct 2012"=>20, 
            "Thu, 11 Oct 2012"=>68 } 
  end

end
