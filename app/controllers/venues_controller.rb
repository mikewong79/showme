class VenuesController < ApplicationController
  before_action :set_venue, only:[:show, :edit, :update, :destroy]
  def index
    @venues = Venue.all
  end

  def show
  end

  def new
    @venue = Venue.new
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

  protected

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :street_address_1, :city, :state, :zip, :phone, :website, :photo)
  end

  # def delete
  # end

  # def update
  # end

  
end
