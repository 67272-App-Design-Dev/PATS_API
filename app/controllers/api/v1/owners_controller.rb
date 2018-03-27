module Api::V1
  class OwnersController < ApplicationController
    # Start with swagger docs info
    swagger_controller :owners, "Owner Management"

    swagger_api :index do
      summary "Fetches all Owner objects"
      notes "This lists all the owners in PATS system"
      param :query, :active, :boolean, :optional, "Filter on whether or not the owner is active"
      param :query, :alphabetical, :boolean, :optional, "Order owners alphabetically by last name, first name"
    end

    swagger_api :show do
      summary "Shows one Owner object"
      param :path, :id, :integer, :required, "Owner ID"
      notes "This lists details of one owner in PATS"
      response :not_found
    end

    swagger_api :create do
      summary "Creates a new Owner"
      param :form, :first_name, :string, :required, "First name"
      param :form, :last_name, :string, :required, "Last name"
      param :form, :street, :string, :optional, "Street"
      param :form, :city, :string, :optional, "City"
      param :form, :state, :string, :optional, "State"
      param :form, :zip, :string, :optional, "Zip Code"
      param :form, :phone, :string, :optional, "Phone"
      param :form, :email, :string, :optional, "Email"
      param :form, :active, :boolean, :optional, "Active"
      param :form, :username, :string, :required, "Username"
      param :form, :password, :string, :required, "Password"
      param :form, :password_confirmation, :string, :required, "Password Confirmation"
      response :not_acceptable
    end

    swagger_api :update do
      summary "Updates an existing Owner"
      param :path, :id, :integer, :required, "Owner ID"
      param :form, :first_name, :string, :optional, "First name"
      param :form, :last_name, :string, :optional, "Last name"
      param :form, :street, :string, :optional, "Street"
      param :form, :city, :string, :optional, "City"
      param :form, :state, :string, :optional, "State"
      param :form, :zip, :string, :optional, "Zip Code"
      param :form, :phone, :string, :optional, "Phone"
      param :form, :email, :string, :optional, "Email"
      param :form, :active, :boolean, :optional, "Active"
      param :form, :username, :string, :optional, "Username"
      param :form, :password, :string, :optional, "Password"
      param :form, :password_confirmation, :string, :optional, "Password Confirmation"
      response :not_found
      response :not_acceptable
    end

    swagger_api :destroy do
      summary "Deletes an existing Owner"
      param :path, :id, :integer, :required, "Owner ID"
      response :not_found
      response :not_acceptable
    end

    # ----------------------
    # Actual controller code
    before_action :set_owner, only: [:show, :update, :destroy]

    def index
      @owners = Owner.all
      if(params[:active].present?)
        @owners = params[:active] == "true" ? @owners.active : @owners.inactive
      end
      if params[:alphabetical].present? && params[:alphabetical] == "true"
        @owners = @owners.alphabetical
      end
      render json: @owners
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
          render json: @owner, status: :created, location: [:v1, @owner]
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
end