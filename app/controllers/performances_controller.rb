class PerformancesController < ApplicationController
  before_action :set_performance, only:[:show, :edit, :update, :destroy]
  respond_to :json, :html
  def index
    @performances = Performance.all
    respond_with @performances
  end

  def show
    respond_with @performance
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
      respond_to do |format|
        format.html {redirect_to venue_path(params[:venue_id])}
        format.json {render json: @performance, status: :created}
      end
    else
      respond_to do |format|
        format.html {render :new}
        format.json {render json: @performance.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    if @performance.update(performance_params)
      respond_to do |format|
        format.html {redirect_to venue_path(@performance.venue)}
        format.json {render nothing: true, status: :no_content}
      end
    else
      format.html { render :edit }
      format.json { render json: @perfomance.errors, status: :unprocessable_entity}
    end
  end

  def destroy
    venue = @performance.venue
    @performance.destroy
    format.html { redirect_to venue_path(venue) }
    format.json { render json: { head: ok } }
    
  end

  protected

  def set_performance
    @performance = Performance.find(params[:id])
  end

  def performance_params
    params.require(:performance).permit(:name, :date, :time, :description, :venue_id, :songkick_id, :artist_ids => [])
  end

end
