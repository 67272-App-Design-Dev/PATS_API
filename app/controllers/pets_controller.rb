class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :update, :destroy]

  def index
    @active_pets = Pet.active.alphabetical.all
    render json: @active_pets
  end

  def show
    render json: @pet
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
