class DosagesController < ApplicationController
  
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