class VideosController < ApplicationController
  respond_to :json

  def index
    videos = video.public.paginate(page)

    respond_with videos, meta: { total: total, unplayed: unplayed, page: page }
  end

  protected

  def total
    Video.public.count
  end

  def unplayed
    if current_user
      Video.unplayed_count(current_user)
    else
      nil
    end
  end

  def video
    if current_user
      Video.user_played(current_user)
    else
      Video
    end
  end
end
