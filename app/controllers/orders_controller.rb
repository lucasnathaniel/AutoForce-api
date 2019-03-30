class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    
    #force status do 0(ready) and empty batch_id 
    new_order_params = ActiveSupport::JSON.decode(ActiveSupport::JSON.encode(order_params))
    new_order_params.merge!({:status=>0}).delete("batch_id")

    @order = Order.new(new_order_params)
    
    #If param is missing
    if new_order_params.length != 9
      destroy
    end
    
    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:reference, :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_item, :status, :batch_id)
    end
end
