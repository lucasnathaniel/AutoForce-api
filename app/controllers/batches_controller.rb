class BatchesController < ApplicationController
  before_action :set_batch_reference, only: [:produce, :close]
  before_action :set_batch_purchase_channel, only: [:financial_report]
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
    @batch = Batch.new(batch_params.merge(reference: Time.now.strftime("%Y%M-"<<Batch.all.size.to_s)))
    @batch.save
    count = 0
    Order.find_each do |order|
      if batch_params[:purchase_channel] == order[:purchase_channel]
        order[:batch_id] = @batch[:id]
        order[:status] = 1
        order.save
        count+=1
      end
    end

    if @batch.save
      render json: @batch.as_json.merge(count_orders: count), status: :created, location: @batch
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
    count = 0
    sum = 0
    Order.find_each do |order|
      if order[:batch_id] == @batch[:id]
        count+=1
        sum+=order[:total_value]
      end
    end
    render json: @batch.as_json.merge(count_orders: count, total_value_report: sum)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch_reference
      @batch = Batch.find_by(reference: params[:reference])
    end

    def set_batch_purchase_channel
      @batch = Batch.find_by(purchase_channel: params[:purchase_channel])
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
