class VenuesController < ApplicationController

  before_action :set_venue, only:[:show, :edit, :update, :destroy]

  def map
    @venues = Venue.all
  end

  def index
    if signed_in?
      @venues = current_owner.venues
    else
      redirect_to new_owner_session_path
    end
  end

  def show
  end

  def new
    if signed_in?
      @venue = Venue.new
    else
      redirect_to new_owner_session_path
    end

  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      redirect_to venues_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @venue.update(venue_params)
      redirect_to venues_path
    else
      render :edit
    end
  end

  def destroy
    @venue.destroy
    redirect_to venues_path
  end


  protected

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :street_address_1, :city, :state, :zip, :phone, :website, :owner_id, :photo, :lat, :lng, :songkick_id)
  end

end
