class UsersController < ApplicationController
  skip_filter :set_user, :check_user
  
  def show
    valid = (params[:id]==test[:email])
    respond_to do |format|
      format.all { render json: {valid: valid, email: params[:id]} }
    end
  end
end
