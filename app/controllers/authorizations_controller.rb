class AuthorizationsController < ApplicationController
  before_filter :signed_in_user
  # GET /authorizations
  # GET /authorizations.json

  def index
    @google_auth = current_user.authorizations.find_by_provider("google")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authorizations }
    end
  end

  # GET /authorizations/1
  # GET /authorizations/1.json
  def show
    @authorization = Authorization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @authorization }
    end
  end

  # GET /authorizations/new
  # GET /authorizations/new.json
  def new
    @authorization = Authorization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authorization }
    end
  end

  # GET /authorizations/1/edit
  def edit
    @authorization = Authorization.find(params[:id])
  end

  # POST /authorizations
  # POST /authorizations.json
  def create
    # auth = request.env["omniauth.auth"]
    # google_token = session[:google_token] = auth.credentials.token
    # google_secret= session[:google_secret] = auth.credentials.secret
    
    auth = request.env["omniauth.auth"]
    token = auth.credentials.token
    secret = auth.credentials.secret
    @authorization = current_user.authorizations.new(token: token, secret: secret, uid: auth.uid, provider: auth.provider)
    
    

    respond_to do |format|
      if @authorization.save
        if authorized_all_providers? 
          format.html { redirect_to default_dashboard_url }
        else
        format.html { redirect_to authorizations_url, notice: 'Authorization was successfully created.' }
          format.json { render json: @authorization, status: :credentialseated, location: @authorization }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @authorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /authorizations/1
  # PUT /authorizations/1.json
  def update
    @authorization = Authorization.find(params[:id])

    respond_to do |format|
      if @authorization.update_attributes(params[:authorization])
        format.html { redirect_to @authorization, notice: 'Authorization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @authorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authorizations/1
  # DELETE /authorizations/1.json
  def destroy
    @authorization = Authorization.find(params[:id])
    @authorization.destroy

    respond_to do |format|
      format.html { redirect_to authorizations_url }
      format.json { head :no_content }
    end
  end

  def google
    api_key = "tKHc-DDjWZu3mern4k1u7ndN"
    @consumer = OAuth::Consumer.new('472837297406.apps.googleusercontent.com', api_key, {
        :site => 'https://www.google.com',
        :request_token_path => '/accounts/OAuthGetRequestToken',
        :access_token_path => '/accounts/OAuthGetAccessToken',
        :authorize_path => '/accounts/OAuthAuthorizeToken'
      })
    @callback_url = "http://127.0.0.1:3000/oauth/callback"
    # @request_token = @consumer.get_request_token(:oauth_callback => @callback_url)
    #session[:request_token] = @request_token
    redirect_to @consumer.get_request_token(:oauth_callback => @callback_url).authorize_url(:oauth_callback => @callback_url)

  end

  protected

  def authorized_all_providers? 
    google_authorized? && tumblr_authorized? ? true : false
  end
end
