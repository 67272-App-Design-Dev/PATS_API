class VisitsController < ApplicationController
    # Start with swagger docs info
  swagger_controller :visits, "Visit Management"

  swagger_api :index do
    summary "Fetches all Visit objects"
    notes "This lists all the visits in PATS system"
    param :query, :chronological, :boolean, :optional, "Order visits chronologically by visit date"
  end

  swagger_api :show do
    summary "Shows one Visit object"
    param :path, :id, :integer, :required, "Visit ID"
    notes "This lists details of one visit in PATS"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Visit"
    param :form, :pet_id, :integer, :required, "Pet ID"
    param :form, :date, :date, :required, "Date"
    param :form, :weight, :float, :required, "Weight"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Visit"
    param :path, :id, :integer, :required, "Visit ID"
    param :form, :pet_id, :integer, :optional, "Pet ID"
    param :form, :date, :date, :optional, "Date"
    param :form, :weight, :float, :optional, "Weight"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Visit"
    param :path, :id, :integer, :required, "Visit ID"
    response :not_found
    response :not_acceptable
  end

  # ----------------------
  # Actual controller code
  before_action :set_visit, only: [:show, :update, :destroy]

  def index
    @visits = Visit.all
    if params[:chronological].present? && params[:chronological] == "true"
      @visits = @visits.chronological
    end
    render json: @visits
  end
  
  def show
    render json: @visit
  end
  
  def create
    @visit = Visit.new(visit_params)
    if @visit.save
      render json: @visit
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @visit.update_attributes(visit_params)
      render json: @visit
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @visit.destroy
    if !@visit.destroyed?
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  private
    def set_visit
      @visit = Visit.find(params[:id])
    end

    def visit_params
      params.permit(:pet_id, :date, :weight)
    end

end
