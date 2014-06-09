class ArtistsController < ApplicationController
 before_action :set_artist, only: [:show, :edit, :update, :destroy]
  respond_to :json, :html

  def index
    @artists = Artist.all
    respond_with @artists
  end

  def show
    respond_with @artist
  end

  def new
    @artist = Artist.new
  end

  def edit

  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      respond_to do |format|
        format.html {redirect_to artists_path(params[:venue_id])}
        format.json {render json: @artist, status: :created}
      end
    else
      respond_to do |format|
        format.html {render :new}
        format.json {render json: @artist.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
  end

  def destroy
  end


  protected

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name, :genre, :songkick_id, :album_key, :rdio_id, :embed_url)
  end
end


