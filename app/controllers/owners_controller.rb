class OwnersController < ApplicationController
before_action :set_owner, only:[:show, :edit, :update, :destroy]
before_action :authenticate_owner!, only:[:edit, :update, :destroy]

  def index
    @owners = Owner.all
  end

  def show
  end

  def new
    @owner = Owner.new
  end

  def edit
  end

  def create
    @owner=Owner.new(owner_params)
    if @owner.save
      redirect_to owners_path
    else
      render :new
    end
  end
  protected

  def set_owner
    @owner = Owner.find(params[:id])
  end

  def owner_params
    params.require(:owner).permit(:first_name, :last_name, :email)
  end
end
