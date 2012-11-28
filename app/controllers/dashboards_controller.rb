class DashboardsController < ApplicationController

  before_filter :signed_in_user
  before_filter :create_garb_session
  before_filter :at_least_one_dashboard, only: :index
  before_filter :authorized_user, only: [:show, :update, :edit, :destroy]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = current_user.dashboards


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dashboards }
    end
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
    @dashboard = current_user.dashboards.find_by_id(params[:id])
    @dashboard.datasource(session[:google_token], session[:google_secret])
    @sources = @dashboard.sources_per_page('/post/36067940845/think-smaller')
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/new
  # GET /dashboards/new.json
  def new
    @dashboard = current_user.dashboards.new
    @profiles = @ga.profiles
     # @profiles = current_user.profiles

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/1/edit
  def edit
    @dashboard = Dashboard.find(params[:id])
    @profiles = @ga.profiles
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = current_user.dashboards.new(params[:dashboard])

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render json: @dashboard, status: :created, location: @dashboard }
      else
        @profiles = @ga.profiles
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
        @profiles = @ga.profiles
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

protected

  def create_garb_session
    @ga = GoogleAnalytics.new(session[:google_token], session[:google_secret]) 
  end

  def at_least_one_dashboard
    if Dashboard.count == 0
      redirect_to new_dashboard_url, notice: "Please create a dashboard."
    end
  end

  def authorized_user
    dashboard = current_user.dashboards.find_by_id(params[:id])
    redirect_to root_path unless dashboard
  end
end
