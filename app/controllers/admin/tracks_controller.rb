class Admin::TracksController < AdminController
  before_filter :authenticate_admin!

  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to admin_track_path(@track), notice: "Updated track"
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])

    if @track.update_attributes(track_params)
      redirect_to admin_track_path(@track), notice: "Updated track"
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    redirect_to admin_tracks_path, notice: "Poor lil guy :("
  end

  protected

  def track_params
    params.require(:track).permit(:title, :hidden, :promoted)
  end
end
