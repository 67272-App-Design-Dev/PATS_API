class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update, :destroy]

  def index
    @active_owners = Owner.active.alphabetical.all
    render json: @active_owners
  end

  def show
    render json: @owner
  end

  def create
    @owner = Owner.new(owner_params)
    @user = User.new(user_params)
    @user.role = "owner"
    if !@user.save
      render json: @user.errors, status: :unprocessable_entity
    else
      @owner.user_id = @user.id
      if @owner.save
        render json: @owner
      else
        render json: @owner.errors, status: :unprocessable_entity
      end      
    end
  end

  def update
    if @owner.update(owner_params)
      render json: @owner
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @owner.destroy
    if !@owner.destroyed?
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  private
    def set_owner
      @owner = Owner.find(params[:id])
    end

    def owner_params
      params.permit(:first_name, :last_name, :street, :city, :state, :zip, :phone, :email, :active, :username, :password, :password_confirmation)
    end

    def user_params
      params.permit(:first_name, :last_name, :active, :username, :password, :password_confirmation)
    end

end