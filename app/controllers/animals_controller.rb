class AnimalsController < ApplicationController
    # Start with swagger docs info
  swagger_controller :animals, "Animal Management"

  swagger_api :index do
    summary "Fetches all Animal objects"
    notes "This lists all the animals in PATS system"
    param :query, :alphabetical, :boolean, :optional, "Order animals alphabetically by name"
  end

  swagger_api :show do
    summary "Shows one Animal object"
    param :path, :id, :integer, :required, "Animal ID"
    notes "This lists details of one animal in PATS"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Animal"
    param :form, :name, :string, :required, "Name"
    param :form, :active, :boolean, :optional, "Active"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Animal"
    param :path, :id, :integer, :required, "Animal ID"
    param :form, :name, :string, :optional, "Name"
    param :form, :active, :boolean, :optional, "Active"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Animal"
    param :path, :id, :integer, :required, "Animal ID"
    response :not_found
    response :not_acceptable
  end

  # ----------------------
  # Actual controller code

  before_action :set_animal, only: [:show, :update, :destroy]

  def index
    @animals = Animal.all
    if params[:alphabetical].present? && params[:alphabetical] == "true"
      @animals = @animals.alphabetical
    end
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
