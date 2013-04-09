class FeedsController < ApplicationController
  respond_to :json

  def index
    if current_user
      feeds = Genre.find(params[:genre_id]).feeds.user_unplayed(current_user)
    else
      feeds = Genre.find(params[:genre_id]).feeds.order(:title)
    end

    respond_with feeds
  end

  def show
    if current_user
      feed = Feed.user_unplayed(current_user).where(id: params[:id]).first
    else
      feed = Feed.find(params[:id])
    end

    respond_with feed
  end

  def played
    Feed.find(params[:id]).mark_as_played(current_user)

    render json: :ok
  end
end
