class PlaysController < ApplicationController
  before_filter :authenticate_user!

  def create
    current_user.plays.create(play_params)

    render json: {}
  end

  protected

  def play_params
    params.require(:play).permit(:playable_id)
  end
end
