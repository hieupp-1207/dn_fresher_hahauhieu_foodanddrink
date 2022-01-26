class Order < ApplicationRecord
  enum status: {pending: 0, rejected: 1, accept: 2, delivered: 3}

  belongs_to :user
  has_many :order_details, dependent: :destroy

  validates :address, :phone, presence: true

  delegate :fullname, :email, to: :user, prefix: true

  scope :sort_orders, ->{order(:status, created_at: :desc)}

  def update_quantity_product
    order_details.each do |order_detail|
      product = order_detail.product
      quantity = product.quantity + order_detail.quantity
      product.update! quantity: quantity
    end
  end
end
