class LoginsController < ApplicationController
  skip_before_filter :check_user, :only => [:index, :new, :authorize, :deauthorize]
  # GET /logins
  # GET /logins.json
  def index
    @logins = Login.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logins }
    end
  end
  
  def list
    @logins = Login.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logins }
    end
  end

  # GET /logins/1
  # GET /logins/1.json
  def show
    @login = Login.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @login }
    end
  end

  # GET /logins/new
  # GET /logins/new.json
  def new
    client = OAuth2::Client.new(DOORKEEPER_APP_ID, DOORKEEPER_APP_SECRET, :site => DOORKEEPER_APP_URL)
    authorize_link = client.auth_code.authorize_url(:redirect_uri => DOORKEEPER_CALLBACK_URL,
      :email_address => "test787433@email.com", :first_name => "john", :last_name => "doe",
      :authorize => (params[:type].blank? ? nil : params[:type]) )
    
    respond_to do |format|
      format.html { redirect_to authorize_link }
      format.json { head :no_content }
    end
  end

  # GET /logins/1/edit
  def edit
    @login = Login.find(params[:id])
  end

  # POST /logins
  # POST /logins.json
  def authorize
    client = OAuth2::Client.new(DOORKEEPER_APP_ID, DOORKEEPER_APP_SECRET, :site => DOORKEEPER_APP_URL)
    code = params[:code]
    @login = Login.new(:code => code)
    token = client.auth_code.get_token(code, :redirect_uri => DOORKEEPER_CALLBACK_URL) rescue nil

    respond_to do |format|
      if token && @login.save
        session[:current_user_id] = @login.id
        session[:name] = JSON.parse(token.get("/api/v1/profiles/default.json").body)["profile_name"]
        session[:auth_hash] = token.to_hash.to_s
        format.html do
          flash[:notice] = 'You have successfully been logged in.'
          redirect_to "/"
        end
        format.json { render json: @login, status: :created, location: @login }
      else
        format.html { redirect_to "/", notice: 'Login was unsuccessful.' }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def deauthorize
    respond_to do |format|
      reset_session
      format.html { redirect_to "/", notice: 'You have been logged out.' }
      format.json { render json: "", status: :logout }
    end
  end

  # PUT /logins/1
  # PUT /logins/1.json
  def update
    @login = Login.find(params[:id])

    respond_to do |format|
      if @login.update_attributes(params[:login])
        format.html { redirect_to @login, notice: 'Login was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logins/1
  # DELETE /logins/1.json
  def destroy
    @login = Login.find(params[:id])
    @login.destroy

    respond_to do |format|
      format.html { redirect_to logins_url }
      format.json { head :no_content }
    end
  end
end
