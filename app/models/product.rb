class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
  scope :limit_8, ->{limit Settings.number.digit_8}
  scope :search, ->(term){where("name LIKE ?", "%#{term}%") if term.present?}
  scope :by_ids, ->(product_ids){where(id: product_ids)}
end
