class RegistrationsController < ApplicationController
  respond_to :json

  def create
    user = User.new(registration_params)

    if user.save
      sign_in user
      render json: user
    else
      respond_with user
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:email, :password)
  end
end
