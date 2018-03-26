class UsersController < ApplicationController
  # Start with swagger docs info
  swagger_controller :users, "User Management"

  swagger_api :index do
    summary "Fetches all User objects"
    notes "This lists all the users in PATS system"
  end

  swagger_api :create do
    summary "Creates a new User"
    param :form, :first_name, :string, :required, "First name"
    param :form, :last_name, :string, :required, "Last name"
    param :form, :username, :string, :required, "Username"
    param :form, :password, :string, :required, "Password"
    param :form, :password_confirmation, :string, :required, "Password Confirmation"
    param :form, :role, :string, :required, "Role [vet|assistant|owner]"
    param :form, :active, :boolean, :optional, "Active"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing User"
    param :path, :id, :integer, :required, "User ID"
    param :form, :first_name, :string, :optional, "First name"
    param :form, :last_name, :string, :optional, "Last name"
    param :form, :username, :string, :optional, "Username"
    param :form, :password, :string, :optional, "Password"
    param :form, :password_confirmation, :string, :optional, "Password Confirmation"
    param :form, :role, :string, :optional, "Role [vet|assistant|owner]"
    param :form, :active, :boolean, :optional, "Active"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing User"
    param :path, :id, :integer, :required, "User ID"
    response :not_found
    response :not_acceptable
  end

  # ----------------------
  # Actual controller code
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
      params.permit(:first_name, :last_name, :active, :username, :role, :password, :password_confirmation, :api_key)
    end

end
