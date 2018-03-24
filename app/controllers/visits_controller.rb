class VisitsController < ApplicationController
  # A callback to set up an @visit object to work with 
  before_action :set_visit, only: [:show, :update, :destroy]

  def index
    @visits = Visit.chronological.paginate(page: params[:page]).per_page(10)
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
