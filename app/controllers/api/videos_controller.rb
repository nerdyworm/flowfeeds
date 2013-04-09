class Api::VideosController < ApplicationController
  before_filter :authenticate_admin!
  skip_before_filter :verify_authenticity_token

  def create
    video = Video.new(video_params)
    video.save!

    render json: video
  end

  protected

  def video_params
    params.require(:video).permit(:title, :youtube_id, :artist_name)
  end
end
