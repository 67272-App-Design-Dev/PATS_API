class ProceduresController < ApplicationController
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