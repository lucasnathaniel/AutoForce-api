require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url, as: :json
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { address: @order.address, batch_id: @order.batch_id, client_name: @order.client_name, delivery_service: @order.delivery_service, line_item: @order.line_item, purchase_channel: @order.purchase_channel, reference: @order.reference, status: @order.status, total_value: @order.total_value } }, as: :json
    end

    assert_response 201
  end

  test "should show order" do
    get order_url(@order), as: :json
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { address: @order.address, batch_id: @order.batch_id, client_name: @order.client_name, delivery_service: @order.delivery_service, line_item: @order.line_item, purchase_channel: @order.purchase_channel, reference: @order.reference, status: @order.status, total_value: @order.total_value } }, as: :json
    assert_response 200
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order), as: :json
    end

    assert_response 204
  end
end
