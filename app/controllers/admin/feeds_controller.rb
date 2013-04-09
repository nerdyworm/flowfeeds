class Admin::FeedsController < AdminController
  before_filter :authenticate_admin!

  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find(params[:id])
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)

    if @feed.save
      redirect_to admin_feed_path(@feed), notice: "Updated feed"
    else
      render :new
    end
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id])

    if @feed.update_attributes(feed_params)
      redirect_to admin_feed_path(@feed), notice: "Updated feed"
    else
      render :edit
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    redirect_to admin_feeds_path, notice: "Poor lil guy :("
  end

  def enqueue_updater
    Resque.enqueue(FeedUpdater, params[:id])
  end

  protected

  def feed_params
    params.require(:feed).permit(
      :artist_id,
      :artist_name,
      :description,
      :genre_id,
      :image,
      :title,
      :url,
      :website
    )
  end
end
