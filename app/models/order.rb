class Order < ApplicationRecord
  enum status: [:ready, :production, :closing, :sent]
  belongs_to :batch, optional: true
end
