class UserController < ApplicationController
  before_action :permit_params, :authenticate_user!

  def edit

  end

  def update
    @user = User.all.find(params[:id])
  end

  private

  def permit_params
    params.permit(:id, :fname, :lname, :address, :city, :zip, :country, :phone)
  end
end
