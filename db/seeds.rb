Category.create!(name: "Thit",
                 parent_id: 1)
30.times do |n|
  name = Faker::Food.fruits
  description = "example-#{n+1}@railstutorial.org"
  image = "banner.jpg"
  price = Faker::Number.decimal(l_digits: 5, r_digits: 2)
  quantity = 50
  rating = 1
  category_id = 1
  Product.create!(name: name,
                  description: description,
                  image: image,
                  price: price,
                  quantity: quantity,
                  rating: rating,
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
25.times do |n|
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

25.times do |n|
  user_id = n + 1
  address = Faker::Address.full_address
  phone = Faker::PhoneNumber.phone_number
  order = Order.new user_id: user_id, address: address, phone: phone
  4.times do |m|
    product_id = 1 + m
    product_id = n + m if n > 0
    price = Product.find(product_id).price
    order.order_details.build product_id: product_id, quantity: 2, price: price
    order.total_price += price
  end
  order.save!
end

25.times do |n|
  user_id = 2
  address = Faker::Address.full_address
  phone = Faker::PhoneNumber.phone_number
  total_price = n + 1
  Order.create!(
      user_id: user_id,
      address: address,
      phone: phone,
      total_price: total_price
  )
end

25.times do |n|
  order_id = 24
  quantity = n + 1
  price = n + 2
  product_id = 1
  OrderDetail.create!(
      order_id: order_id,
      quantity: quantity,
      price: price,
      product_id: product_id
  )
end
