class TreatmentsController < ApplicationController

  def create
    @treatment = Treatment.new(treatment_params)
    if @treatment.save
      render json: @treatment
    else
      render json: @treatment.errors, status: :unprocessable_entity
    end
  end
 
  def destroy
    @treatment = Treatment.find(params[:id])
    @treatment.destroy
    if !@treatment.destroyed?
      render json: @treatment.errors, status: :unprocessable_entity
    end
  end

  private
    def treatment_params
      params.permit(:visit_id, :procedure_id, :successful, :discount)
    end

end