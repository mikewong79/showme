class VenuesController < ApplicationController

  before_action :set_venue, only:[:show, :edit, :update, :destroy]
  respond_to :json, :html

  def map
    @venues = current_owner.venues
  end

  def index
    @venues = Venue.all
    respond_with @venues
  end

  def show
    respond_with @venue
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      respond_to do |format|
      format.html {redirect_to venues_path}
      format.json {render json: @venue, status: :created}
      end
    else
      respond_to do |format|
      format.html {render :new}
      format.json {render json: @venue.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
    if @venue.update(venue_params)
        respond_to do |format|
        format.html {redirect_to venues_path}
        format.json {render nothing: true, status: :no_content}
      end
    else
      format.html { render :edit}
      format.json { render json: @venue.errors, status: :unprocessable_entity}
    end
  end

  def destroy
    @venue.destroy
    format.html { redirect_to venues_path }
    format.json { render json: { head: ok } }
  end


  protected

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :street_address_1, :city, :state, :zip, :phone, :website, :owner_id, :photo, :lat, :lng, :songkick_id)
  end

end
