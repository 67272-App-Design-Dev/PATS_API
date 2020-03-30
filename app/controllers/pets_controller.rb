class PetsController < ApplicationController
    # Start with swagger docs info
  swagger_controller :pets, "Pet Management"

  swagger_api :index do
    summary "Fetches all Pet objects"
    notes "This lists all the pets in PATS system"
  end

  swagger_api :show do
    summary "Shows one Pet object"
    param :path, :id, :integer, :required, "Pet ID"
    notes "This lists details of one pet in PATS"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Pet"
    param :form, :name, :string, :required, "Name"
    param :form, :animal_id, :integer, :required, "Animal ID"
    param :form, :owner_id, :integer, :required, "Owner ID"
    param :form, :female, :boolean, :optional, "Female"
    param :form, :date_of_birth, :date, :optional, "Date of Birth"
    param :form, :active, :boolean, :optional, "Active"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Pet"
    param :path, :id, :integer, :required, "Pet ID"
    param :form, :name, :string, :optional, "Name"
    param :form, :animal_id, :integer, :optional, "Animal ID"
    param :form, :owner_id, :integer, :optional, "Owner ID"
    param :form, :female, :boolean, :optional, "Female"
    param :form, :date_of_birth, :date, :optional, "Date of Birth"
    param :form, :active, :boolean, :optional, "Active"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Pet"
    param :path, :id, :integer, :required, "Pet ID"
    response :not_found
    response :not_acceptable
  end

  # ----------------------
  # Actual controller code

  before_action :set_pet, only: [:show, :update, :destroy]

  def index
    @active_pets = Pet.active.alphabetical.all
    render json: PetSerializer.new(@active_pets).serializable_hash
  end

  def show
    render json: PetSerializer.new(@pet).serializable_hash
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      render json: @pet
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  def update
    if @pet.update(pet_params)
      render json: @pet
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    if !@pet.destroyed
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  private
  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.permit(:name, :animal_id, :owner_id, :female, :date_of_birth, :active)
  end

end
