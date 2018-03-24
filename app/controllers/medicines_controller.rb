class MedicinesController < ApplicationController
  before_action :set_medicine, only: [:show, :update, :destroy]

  def index
    @medicines = Medicine.alphabetical.all
    render json: @medicines
  end
  
  def show
    render json: @medicine
  end
  
  def create
    @medicine = Medicine.new(medicine_params)
    if @medicine.save
      render json: @medicine
    else
      render json: @medicine.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @medicine.update(medicine_params)
      render json: @medicine
    else
      render json: @medicine.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @medicine.destroy
    if !@medicine.destroyed?
      render json: @medicine.errors, status: :unprocessable_entity
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def medicine_params
      params.permit(:name, :description, :stock_amount, :admin_method, :unit, :vaccine, :active)
    end
end
