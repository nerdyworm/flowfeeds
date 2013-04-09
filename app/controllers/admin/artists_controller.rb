class Admin::ArtistsController < AdminController
  before_filter :authenticate_admin!

  def index
    @artists = Artist.all
  end

  def autocomplete
    @artists = Artist.where("name like ?", "%#{params[:q]}%")

    render json: @artists
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to admin_artist_path(@artist), notice: "Updated artist"
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    if @artist.update_attributes(artist_params)
      redirect_to admin_artist_path(@artist), notice: "Updated artist"
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    redirect_to admin_artists_path, notice: "Poor lil guy :("
  end

  protected

  def artist_params
    params.require(:artist).permit(:name)
  end
end
