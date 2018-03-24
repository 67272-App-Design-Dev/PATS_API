class ProceduresController < ApplicationController
  # Start with swagger docs info
  swagger_controller :procedures, "Procedure Management"

  swagger_api :index do
    summary "Fetches all Procedure objects"
    notes "This lists all the procedures in PATS system"
  end

  swagger_api :show do
    summary "Shows one Procedure object"
    param :path, :id, :integer, :required, "Procedure ID"
    notes "This lists details of one procedure in PATS"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Procedure"
    param :form, :name, :string, :required, "Name"
    param :form, :description, :text, :optional, "Description"
    param :form, :length_of_time, :integer, :required, "Length of Time"
    param :form, :active, :boolean, :optional, "Active"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Procedure"
    param :path, :id, :integer, :required, "Procedure ID"
    param :form, :name, :string, :optional, "Name"
    param :form, :description, :text, :optional, "Description"
    param :form, :length_of_time, :integer, :optional, "Length of Time"
    param :form, :active, :boolean, :optional, "Active"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Procedure"
    param :path, :id, :integer, :required, "Procedure ID"
    response :not_found
    response :not_acceptable
  end

  # ----------------------
  # Actual controller code
  before_action :set_procedure, only: [:show, :edit, :update, :destroy]

  def index
    @procedures = Procedure.alphabetical.all
    render json: @procedures
  end
  
  def show
    render json: @procedure
  end
  
  def create
    @procedure = Procedure.new(procedure_params)
    if @procedure.save
      render json: @procedure
    else
      render json: @procedure.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @procedure.update_attributes(procedure_params)
      render json: @procedure
    else
      render json: @procedure.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @procedure.destroy
    if !@procedure.destroyed
      render json: @procedure.errors, status: :unprocessable_entity
    end
    
  end

  private
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    def procedure_params
      params.permit(:name, :description, :length_of_time, :active)
    end
end