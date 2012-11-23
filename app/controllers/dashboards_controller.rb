class DashboardsController < ApplicationController

  before_filter :signed_in_user, :set_oauth

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
    ga = ga.profile(@dashboard.web_property_id)


    #Chart
    @visits = ga.visits
    
    # Content & Sources 
    @sources = ga.sources.sort {|e| -e.visits.to_i }.take(10)
    @pages = ga.pages.sort {|e| -e.visits.to_i }.take(10)

    # Snapshot
    @snap = ga.snapshot.first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dashboard }
    end
  end

  # GET /dashboards/new
  # GET /dashboards/new.json
  def new
    @dashboard = Dashboard.new
    ga = GoogleAnalytics.new
    # @webproperties = ga.web_properties(@garbsession)
    @webproperties = Garb::Management::Profile.all(@garbsession)

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

  def set_oauth
    api_key = "tKHc-DDjWZu3mern4k1u7ndN"
    if session[:google_token] and session[:google_secret]
      consumer = OAuth::Consumer.new('472837297406.apps.googleusercontent.com', api_key, {
        :site => 'https://www.google.com',
        :request_token_path => '/accounts/OAuthGetRequestToken',
        :access_token_path => '/accounts/OAuthGetAccessToken',
        :authorize_path => '/accounts/OAuthAuthorizeToken'
      })
      @garbsession = Garb::Session.new
      @garbsession.access_token = OAuth::AccessToken.new(consumer, session[:google_token], session[:google_secret])
      @authorized = true
    else 
      redirect_to root_path
    end
  end
end
