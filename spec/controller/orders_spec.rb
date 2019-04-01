require 'rails_helper'

describe OrdersController, type: :controller do
  
  ######EndPoints#######
  
  it 'POST create: /orders > 200' do
    request.headers['Content-Type'] = 'application/json'
    post :create, params: {reference: "BR102030", purchase_channel: "Site BR", client_name: "Joao", address: "rua do limao", delivery_service: "SEDEX", total_value: 666.66, line_item: "iphone"}
 	order_tester = Order.last
 	response_body = JSON.parse(response.body)
 	expect(response_body.fetch('reference')).to eq(order_tester.reference)
 	expect(response_body.fetch('purchase_channel')).to eq(order_tester.purchase_channel)
 	expect(response_body.fetch('client_name')).to eq(order_tester.client_name)
 	expect(response_body.fetch('address')).to eq(order_tester.address)
 	expect(response_body.fetch('delivery_service')).to eq(order_tester.delivery_service)
 	expect(response_body.fetch('total_value')).to eq(order_tester.total_value)
 	expect(response_body.fetch('line_item')).to eq(order_tester.line_item)
  end

end