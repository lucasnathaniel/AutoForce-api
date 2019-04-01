class OrdersController < ApplicationController
  before_action :set_order_reference, only: [:search_reference, :update_reference]
  before_action :set_order_name, only: [:search_name, :update_name]
  before_action :set_order_purchase_channel, only: [:search_purchase_channel]

  # POST /orders
  def create
    @order = Order.new(order_params_create.merge(status: 0))
    
    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/update_reference/:reference
  def update_reference
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # GET /orders/search/reference/:reference
  def search_reference
    render json: @order
  end

  # GET /orders/search/name/:client_name
  def search_name
    render json: @order
  end

  # GET /orders/search/purchase_channel/:purchase_channel
  def search_purchase_channel
    render json: @order
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_reference
      @order = Order.find_by(reference: params[:reference])
    end

    def set_order_name
      @order = Order.find_by(client_name: params[:client_name])
    end

    def set_order_purchase_channel
      @order = Order.where(purchase_channel: params[:purchase_channel])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:reference, :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_item, :status, :batch_id)
    end

    def order_params_create
      params.require(:order).permit(:reference, :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_item, :status)
    end

end
