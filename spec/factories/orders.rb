FactoryBot.define do
  factory :order, class: "Order" do
    address {Faker::Address.street_address}
    phone {Faker::PhoneNumber.phone_number}
    status {rand(Order.statuses.values.first..Order.statuses.values.last)}
    user {create :user}
  end
end
