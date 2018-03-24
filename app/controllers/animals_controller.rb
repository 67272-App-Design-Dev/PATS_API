class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :update, :destroy]

  def index
    @animals = Animal.alphabetical.all
    render json: @animals
  end

  def show
    render json: @animal
  end

  def create
    @animal = Animal.new(animal_params)
    if @animal.save
      render json: @animal
    else
      render json: @animal.errors, status: :unprocessable_entity
    end
  end

  def update
    if @animal.update(animal_params)
      render json: @animal
    else
      render json: @animal.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @animal.destroy
    if !@animal.destroyed
      render json: @animal.errors, status: :unprocessable_entity
    end
  end

  private
  def set_animal
    @animal = Animal.find(params[:id])
  end

  def pet_params
    params.permit(:name, :active)
  end

end
