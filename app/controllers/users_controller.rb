class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    # finding all the active owners and paginating that list (will_paginate)
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    if !@user.destroyed?
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:first_name, :last_name, :active, :username, :role, :password, :password_confirmation)
    end

end
