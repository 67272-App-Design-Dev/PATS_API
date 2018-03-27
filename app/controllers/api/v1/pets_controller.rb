module Api::V1
  class PetsController < ApplicationController
      # Start with swagger docs info
    swagger_controller :pets, "Pet Management"

    swagger_api :index do
      summary "Fetches all Pet objects"
      notes "This lists all the pets in PATS system"
      param :query, :active, :boolean, :optional, "Filter on whether or not the pet is active"
      param :query, :females, :boolean, :optional, "Filter on whether or not the pet is female"
      param :query, :for_owner, :integer, :optional, "Filter pets for a given owner id"
      param :query, :by_animal, :integer, :optional, "Filter pets for a given animal id"
      param :query, :born_before, :string, :optional, "Filter pets to find those born before a given date"
      param :query, :alphabetical, :boolean, :optional, "Order pets alphabetically by name"
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

    include Filterable
    include Orderable

    BOOLEAN_FILTERING_PARAMS = [[:active, :inactive], [:females, :males]]
    PARAM_FILTERING_PARAMS = [:for_owner, :by_animal, :born_before]
    ORDERING_PARAMS = [:alphabetical]


    def index
      @pets = boolean_filter(Pet.all, BOOLEAN_FILTERING_PARAMS)
      @pets = param_filter(@pets, PARAM_FILTERING_PARAMS)
      @pets = order(@pets, ORDERING_PARAMS)
      render json: @pets
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
end