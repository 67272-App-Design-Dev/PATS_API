class TreatmentsController < ApplicationController
  # Start with swagger docs info
  swagger_controller :treatments, "Treatment Management"

  swagger_api :create do
    summary "Creates a new Treatment"
    param :form, :visit_id, :integer, :required, "Visit ID"
    param :form, :procedure_id, :integer, :required, "Procedure ID"
    param :form, :discount, :float, :required, "Discount"
    param :form, :successful, :boolean, :optional, "Successful"
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Treatment"
    param :path, :id, :integer, :required, "Treatment ID"
    response :not_found
    response :not_acceptable
  end

  # ----------------------
  # Actual controller code
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