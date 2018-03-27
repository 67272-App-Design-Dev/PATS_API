module Api::V1
  class MedicineCostsController < ApplicationController

    def create
      @medicine_cost = MedicineCost.new(medicine_cost_params)
      @medicine_cost.start_date = Date.current
      # @medicine_cost.cost_per_unit = @medicine_cost.cost_per_unit
      if @medicine_cost.save
        render json: @medicine_cost
      else
        render json: @medicine_cost.errors, status: :unprocessable_entity
      end
    end

    private
    def medicine_cost_params
      params.permit(:medicine_id, :cost_per_unit)
    end
  end
end