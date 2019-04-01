class BatchesController < ApplicationController
  before_action :set_batch_reference, only: [:produce, :close]
  after_action :after_produce, only: [:produce]
  after_action :after_close, only: [:close]
  
  # GET /batches
  def index
    @batches = Batch.all

    render json: @batches
  end

  # GET /batches/1
  def show
    render json: @batch
  end

  # POST /batches
  def create
    @batch = BatchesService.new(batch_params).call

    if @batch.save
      render json: @batch.as_json.merge(count_orders: BatchesService.new(batch_params).counter), status: :created, location: @batch
    else
      render json: @batch.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /batches/1
  def update
    if @batch.update(batch_params)
      render json: @batch
    else
      render json: @batch.errors, status: :unprocessable_entity
    end
  end

  # GET /batches/produce/reference/:reference
  def produce
    render json: @batch
  end

  # GET /batches/close/:reference/:delivery_service
  def close
    render json: @batch
  end

  # GET /batches/financial_report/:purchase_channel
  def financial_report
    @financial = FinancialService.new(params[:purchase_channel]).report
    render json: @financial
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch_reference
      @batch = Batch.find_by(reference: params[:reference])
    end

    # Only allow a trusted parameter "white list" through.
    def batch_params
      params.require(:batch).permit(:reference, :purchase_channel)
    end
    
    def after_produce
      Order.find_each do |order|
        if order[:batch_id] == @batch[:id]
          order[:status] = 2
          order.save
        end
      end
    end

    def after_close
      Order.find_each do |order|
        if order[:batch_id] == @batch[:id] and order[:delivery_service] == params[:delivery_service]
          order[:status] = 3
          order.save
        end
      end
    end
end
