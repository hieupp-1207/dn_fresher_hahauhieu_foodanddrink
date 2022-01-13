FactoryBot.define do
  factory :product do
    name {Faker::Food.fruits}
    description {Faker::Lorem.sentence}
    price {100000}
    quantity {50}
    rating {4.5}
    category {FactoryBot.create(:category)}
  end
end
