class DashboardsController < ApplicationController

  before_filter :signed_in_user
  before_filter :at_least_one_dashboard, only: :index
  before_filter :authorized_user, only: [:show, :update, :edit, :destroy]
  before_filter :can_access_dashboard

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
    @dashboard.datasource(google_token, google_secret)
    @dashboards = current_user.dashboards
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/new
  # GET /dashboards/new.json
  def new
    @dashboard = current_user.dashboards.new
    @dashboard.datasource(google_token, google_secret)
    @profiles =  @dashboard.profiles
    @blogs = current_user.blogs_from_tumblr

     # @profiles = current_user.profiles

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/1/edit
  def edit
    @dashboard = current_user.dashboards.find_by_id(params[:id])
    @dashboard.datasource(google_token, google_secret)
    @profiles = @dashboard.profiles
    @blogs = current_user.blogs_from_tumblr
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = current_user.dashboards.new(params[:dashboard])
    @dashboard.datasource(google_token, google_secret)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render json: @dashboard, status: :created, location: @dashboard }
      else
        @profiles = @dashboard.profiles
        @blogs = current_user.blogs_from_tumblr
        format.html { render action: "new" }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dashboards/1
  # PUT /dashboards/1.json
  def update
    @dashboard = Dashboard.find(params[:id])
    @dashboard.datasource(google_token, google_secret)

    respond_to do |format|
      if @dashboard.update_attributes(params[:dashboard])
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { head :no_content }
      else
        @profiles = @dashboard.profiles
        @blogs = current_user.blogs_from_tumblr
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


  def refresh_blogs
    current_user.authorization_from_tumblr.blogs.create_all_from_tumblr(tumblr_token, tumblr_secret)
    redirect_to new_dashboard_url, notice: "Your Tumblr Blogs have been refreshed."
  end
protected
  def authorized_user
    dashboard = current_user.dashboards.find_by_id(params[:id])
    redirect_to root_path unless dashboard
  end

end
