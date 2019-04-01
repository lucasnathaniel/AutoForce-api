#Order class model, check db/migrate/20190325024817_create_orders.rb

class Order < ApplicationRecord
  enum status: [:ready, :production, :closing, :sent]
  belongs_to :batch, optional: true
end
