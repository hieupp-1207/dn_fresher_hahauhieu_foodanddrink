FactoryBot.define do
  factory :product do
    name { Faker::Food.name }
    description { Faker::Quote }
    image { Faker::Alphanumeric }
    price { Faker::Number.decimal }
    quantity { Faker::Number.digit }
    rating { Faker::Number.digit }
    category_id {create(:category).id}
  end
end
