class Admin::VideosController < AdminController
  before_filter :authenticate_admin!
  skip_before_filter :verify_authenticity_token

  def index
    @videos = Video.order('published desc').all
  end

  def autocomplete
    @videos = Video.where("name like ?", "%#{params[:q]}%")

    render json: @videos
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to admin_video_path(@video), notice: "Updated video"
    else
      render :new
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])

    if @video.update_attributes(video_params)
      redirect_to admin_video_path(@video), notice: "Updated video"
    else
      render :edit
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    redirect_to admin_videos_path, notice: "Poor lil guy :("
  end

  protected

  def video_params
    params.require(:video).permit(:title, :youtube_id, :artist_name, :published)
  end
end
