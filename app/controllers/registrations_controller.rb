class RegistrationsController < ApplicationController
  respond_to :json

  def create
    user = User.new(registraion_params)

    if user.save
      sign_in user
      render json: user
    else
      respond_with user
    end
  end

  private

  def registraion_params
    params.require(:registration).permit(:email, :password)
  end
end
