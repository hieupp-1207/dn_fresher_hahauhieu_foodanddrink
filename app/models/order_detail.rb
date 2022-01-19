class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, to: :product, prefix: true

  scope :sort_by_created_at, ->{order created_at: :desc}
end
