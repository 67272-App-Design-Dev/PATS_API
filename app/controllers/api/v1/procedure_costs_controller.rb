module Api::V1
  class ProcedureCostsController < ApplicationController

    def create
      @procedure_cost = ProcedureCost.new(procedure_cost_params)
      @procedure_cost.start_date = Date.current
      @procedure_cost.cost = @procedure_cost.cost*100 unless @procedure_cost.cost.nil?
      if @procedure_cost.save
        render json: @procedure_cost
      else
        render json: @procedure_cost.errors, status: :unprocessable_entity
      end
    end

    private
    def procedure_cost_params
      params.permit(:procedure_id, :cost)
    end
  end
end