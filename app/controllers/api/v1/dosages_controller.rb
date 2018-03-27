module Api::V1
  class DosagesController < ApplicationController
    # Start with swagger docs info
    swagger_controller :treatments, "Dosage Management"

    swagger_api :create do
      summary "Creates a new Dosage"
      param :form, :visit_id, :integer, :required, "Visit ID"
      param :form, :medicine_id, :integer, :required, "Medicine ID"
      param :form, :units_given, :integer, :required, "Units Given"
      param :form, :discount, :float, :required, "Discount"
      response :not_acceptable
    end

    swagger_api :destroy do
      summary "Deletes an existing Dosage"
      param :path, :id, :integer, :required, "Dosage ID"
      response :not_found
      response :not_acceptable
    end

    # ----------------------
    # Actual controller code  
    def create
      @dosage = Dosage.new(dosage_params)
      if @dosage.save
        render json: @dosage
      else
        render json: @dosage.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @dosage = Dosage.find(params[:id])
      @dosage.destroy
      if !@dosage.destroyed?
        render json: @dosage.errors, status: :unprocessable_entity
      end
    end

    private
    def dosage_params
      params.permit(:visit_id, :medicine_id, :units_given, :discount)
    end
  end
end