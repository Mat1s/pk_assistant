class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile

  def show
    @organizations = current_user.organizations.page params[:page]
    @cars = current_user.cars
    authorize :organization, :new?
  end

  def edit
  end

  def update
    if @profile.update_attributes(permit_params)
      redirect_to @profile
    else
      render :edit
    end
  end

  private

  def find_profile
    @profile = Profile.find_by(id: params[:id])
    authorize @profile
  end

  def permit_params
    params.require(:profile).permit(:image, :firstname, :surname, :nickname,
    :birthday, :address)
  end
end