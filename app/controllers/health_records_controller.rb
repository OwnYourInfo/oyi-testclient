class HealthRecordsController < ApplicationController
  
  def index
    @health_records = get_url('/api/v1/health_records.json') rescue nil
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @health_records }
    end
  end

  def new
    @health_records = get_url('/api/v1/health_records/new.json') rescue nil
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { head :no_content }
    end
  end
  
  def create
    @health_records = post_to_url('/api/v1/health_records/create.json', {:body => {:fields => params[:fields]}})
    
    respond_to do |format|
      format.html { render :show }
      format.json { head :no_content }
    end
  end
  
end
