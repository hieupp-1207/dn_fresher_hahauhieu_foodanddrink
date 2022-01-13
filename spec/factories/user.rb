FactoryBot.define do
  factory :user, class: "User" do
    fullname {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123123"}
    password_confirmation {"123123"}
    role {0}
    address {Faker::Address.full_address}
  end
end
