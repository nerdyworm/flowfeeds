class TracksController < ApplicationController
  respond_to :json

  def index
    count  = track_scope.count
    tracks = track.public.includes(:artist, :feed).paginate(params[:page])

    respond_with tracks, meta: { total: count }
  end

  def unplayed_count
    if current_user
      count = track_scope.unplayed_count(current_user)
    else
      count = track_scope.count
    end

    render json: { unplayed_count: count }
  end

  private

  def track_scope
    if params[:genre_id]
      Genre.find(params[:genre_id]).playables
    elsif params[:feed_id]
      Feed.find(params[:feed_id]).playables
    else
      Track
    end
  end

  def track
    if current_user
      track_scope.user_played(current_user)
    else
      track_scope
    end
  end
end
