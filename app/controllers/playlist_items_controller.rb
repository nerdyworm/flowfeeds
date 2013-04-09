class PlaylistItemsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :json

  def index
    playlist = current_user.playlists.find(params[:playlist_id])
    playlist_items = playlist.items

    ids = playlist_items.collect do |item|
      item.playable_id
    end

    lookup = {}
    Playable.find_with_user_played(ids, current_user).each do |p|
      lookup[p.id.to_s] = p
    end

    playlist_items.each do |item|
      item.playable = lookup[item.playable_id.to_s]
    end

    respond_with playlist_items
  end

  def destroy
    playlist_item = current_user.items.find(params[:id])
    playlist_item.destroy

    respond_with playlist_item
  end

  def order
    ActiveRecord::Base.transaction do
      params.fetch(:playlist_items).each do |index, item_params|
        item = current_user.items.find(item_params.fetch(:id))
        item.update_attribute(:idx, item_params.fetch(:idx))
      end
    end

    render nothing: true
  end
end
