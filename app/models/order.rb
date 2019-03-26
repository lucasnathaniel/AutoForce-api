class Order < ApplicationRecord
  enum status: [:ready, :production, :closing, :sent]
  belongs_to :batch
end
