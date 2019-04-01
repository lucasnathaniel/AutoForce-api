class BatchesController < ApplicationController
  before_action :set_batch_reference, only: [:produce]
  after_action :after_produce, only: [:produce]
  
  #def summary
  #  BatcherSummary.new(params[:batch_id]).total
  #end

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
end
