Category.create!(name: "Thit",
                 parent_id: 1)
5.times do |n|
name = Faker::Name.name
  description = "Tuyet voi"
  price = "50000"
  quantity = 10
  category_id = 1
Product.create!(name: name,
                description: description,
                price: price,
                quantity: quantity,
                category_id: category_id)
end

User.create(
  fullname: "Admin",
  email: "admin@gmail.com",
  role: 1,
  password: "123456",
  password_confirmation: "123456"
)

User.create!(
  fullname: "Ai Cũng được",
  email: "ai@gmail.com",
  password: "654321",
  password_confirmation: "654321")
  5.times do |n|
    fullname = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password = "111111"
    password_confirmation = "111111"
    User.create!(
      fullname: fullname,
      email: email,
      role: 0,
      password: password,
      password_confirmation: password
    )
  end
