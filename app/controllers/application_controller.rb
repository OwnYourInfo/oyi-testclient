class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_user, :check_user
  
  helper_method :current_user, :current_token
  
  def test
    {
      email: "testjklksdsdsdl@hh.com"
    }
  end
  
  private
  
  def current_user
    session[:current_user_id]
  end
  
  def current_token_session
    @token_session
  end
  
  def set_user
    auth_hash = session[:auth_hash]
    client = OAuth2::Client.new(DOORKEEPER_APP_ID, DOORKEEPER_APP_SECRET, :site => DOORKEEPER_APP_URL)
    @token_session = OAuth2::AccessToken.from_hash(client, eval(auth_hash)) rescue nil
  end
  
  def check_user
    cs= current_token_session.get("/api/v1/check_session.json") rescue nil
    if cs.blank?
      flash[:error] = "Your session has expired. Please login again."
      redirect_to "/"
    end
  end
  
  def get_url(url)
    response = current_token_session.get(url)
    JSON.parse(response.body)
  end
  
  def post_to_url(url, hash)
    response = current_token_session.post(url, hash)
    JSON.parse(response.body)
  end
end
