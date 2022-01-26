FactoryBot.define do
  factory :order_detail do
    quantity {2}
    product {FactoryBot.create(:product)}
    price {product.price}
  end
end
