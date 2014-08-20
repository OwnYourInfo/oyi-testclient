class DocumentsController < ApplicationController
  skip_filter :set_user, :check_user, :only => [:show]
  
  def index
    @documents = get_url('/api/v1/documents.json') rescue nil
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  def new
    @document = get_url('/api/v1/documents/new.json') rescue nil
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { head :no_content }
    end
  end
  
  def create
    @health_records = post_to_url('/api/v1/documents/create.json', {:body => {:fields => params[:fields]}})
    
    respond_to do |format|
      format.html { render :show }
      format.json { head :no_content }
    end
  end
  
  def show
    respond_to do |format|
      format.all { render json: {valid: true, url: "https://www.google.com/logos/2012/birthday12-hp.jpg"} }
    end
  end
  
end
