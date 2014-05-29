class PerformancesController < ApplicationController
  before_action :set_performance, only:[:show, :edit, :update, :destroy]

  def index
    @performances = Performance.all
  end

  def show
  end

  def new
    @performance = Performance.new
  end

  def edit
  end

  def create
    @performance=Performance.new(performance_params)
    if @performance.save
      redirect_to performances_path
    else
      render :new
    end
  end
  protected

  def set_performance
    @performance = Performance.find(params[:id])
  end

  def performance_params
    params.require(:performance).permit(:date, :time)
  end

end
