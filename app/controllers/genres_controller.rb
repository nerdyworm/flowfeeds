class GenresController < ApplicationController
  respond_to :json

  def index
    respond_with genre
  end

  def played
    Genre.find(params[:id]).mark_as_played(current_user)

    render json: :ok
  end

  private

  def genre
    if current_user
      Genre.user_unplayed(current_user)
    else
      Genre.all
    end
  end
end
