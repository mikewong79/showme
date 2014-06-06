class PerformancesController < ApplicationController
  before_action :set_performance, only:[:show, :edit, :update, :destroy]

  def index
    @performances = Performance.all
  end

  def show
  end

  def new
    @performance = Performance.new
    @venue = Venue.find(params[:venue_id])
    @artists = Artist.all
  end

  def edit
    @venue = @performance.venue
    @artists = Artist.all
  end

  def create
    @performance = Performance.new(performance_params)
    if @performance.save
      redirect_to venue_path(params[:venue_id])
    else
      render :new
    end
  end

  def update
    if @performance.update(performance_params)
      redirect_to venue_path(@performance.venue)
    else
      render :edit
    end
  end

  def destroy
    venue = @performance.venue
    @performance.destroy
    redirect_to venue_path(venue)
  end

  protected

  def set_performance
    @performance = Performance.find(params[:id])
  end

  def performance_params
    params.require(:performance).permit(:name, :date, :time, :description, :venue_id, :songkick_id, :artist_ids => [])
  end

end
