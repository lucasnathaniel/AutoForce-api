class BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :update, :destroy]
  after_action :after_create, only: [:create]
  
  def summary
    BatcherSummary.new(params[:batch_id]).total
  end


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
    
    if @batch.save
      render json: @batch, status: :created, location: @batch
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

  # DELETE /batches/1
  def destroy
    @batch.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def batch_params
      params.require(:batch).permit(:reference, :purchase_channel)
    end

    def after_create
      Order.find_each do |order|
        if batch_params[:purchase_channel] == order[:purchase_channel]
          order[:batch_id] = @batch[:id]
          order.save
        end
      end
    end
end
