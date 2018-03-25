class MedicinesController < ApplicationController
    # Start with swagger docs info
  swagger_controller :medicines, "Medicine Management"

  swagger_api :index do
    summary "Fetches all Medicine objects"
    notes "This lists all the medicines in PATS system"
    param :query, :active, :boolean, :optional, "Filter on whether or not the medicine is active"
    param :query, :alphabetical, :boolean, :optional, "Order medicines alphabetically by name"
  end

  swagger_api :show do
    summary "Shows one Medicine object"
    param :path, :id, :integer, :required, "Medicine ID"
    notes "This lists details of one medicine in PATS"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Medicine"
    param :form, :name, :string, :required, "Name"
    param :form, :description, :text, :optional, "Description"
    param :form, :stock_amount, :integer, :required, "Stock Amount"
    param :form, :admin_method, :string, :optional, "Admin Method"
    param :form, :unit, :string, :optional, "Unit"
    param :form, :vaccine, :boolean, :optional, "Vaccine"
    param :form, :active, :boolean, :optional, "Active"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Medicine"
    param :path, :id, :integer, :required, "Medicine ID"
    param :form, :name, :string, :optional, "Name"
    param :form, :description, :text, :optional, "Description"
    param :form, :stock_amount, :integer, :optional, "Stock Amount"
    param :form, :admin_method, :string, :optional, "Admin Method"
    param :form, :unit, :string, :optional, "Unit"
    param :form, :vaccine, :boolean, :optional, "Vaccine"
    param :form, :active, :boolean, :optional, "Active"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Medicine"
    param :path, :id, :integer, :required, "Medicine ID"
    response :not_found
    response :not_acceptable
  end

  # ----------------------
  # Actual controller code
  before_action :set_medicine, only: [:show, :update, :destroy]

  def index
    @medicines = Medicine.all
    if(params[:active].present?)
      @medicines = params[:active] == "true" ? @medicines.active : @medicines.inactive
    end
    if params[:alphabetical].present? && params[:alphabetical] == "true"
      @medicines = @medicines.alphabetical
    end
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
