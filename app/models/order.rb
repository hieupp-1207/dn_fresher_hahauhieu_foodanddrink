class Order < ApplicationRecord
  enum status: {pending: 0, accept: 1, delivered: 2, cancel: 3}

  belongs_to :user
  has_many :order_details, dependent: :destroy

  delegate :fullname, :email, to: :user, prefix: true

  scope :sort_orders, ->{order(:status, created_at: :desc)}
end
