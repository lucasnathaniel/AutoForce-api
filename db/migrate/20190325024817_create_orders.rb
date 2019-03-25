class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :reference
      t.string :purchase_channel
      t.string :client_name
      t.string :address
      t.string :delivery_service
      t.float :total_value
      t.text :line_item
      t.integer :status
      t.references :batch, foreign_key: true

      t.timestamps
    end
  end
end
