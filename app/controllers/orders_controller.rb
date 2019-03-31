class OrdersController < ApplicationController
  # controller so precisa receber parametros
  # entregar pra alguem
  # e definir como responder ao usuario

  before_action :set_order_reference, only: [:search_reference, :update_reference]
  before_action :set_order_name, only: [:search_name, :update_name]

  # tratamentos de erro
  #rescue_from do ||
  #end

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # POST /orders
  def create
    @order = Order.new(order_params_create)
    
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

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_reference
      @order = Order.find_by(reference: params[:reference])
    end

    def set_order_name
      @order = Order.find_by(client_name: params[:client_name])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:reference, :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_item, :status, :batch_id)
    end

    def order_params_create
      params.require(:order).permit(:reference, :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_item, :status)
    end
end
