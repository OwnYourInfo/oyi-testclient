class UsersController < ApplicationController
  skip_filter :set_user, :check_user
  
  def show
    respond_to do |format|
      format.all { render json: {valid: true, email: params[:id]} }
    end
  end
end
