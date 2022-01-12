Category.create!(name: "Example User",
                 parent_id: 1)
30.times do |n|
name = Faker::Name.name
  description = "example-#{n+1}@railstutorial.org"
  image = "banner.jpg"
  price = "#{n+1}"
  quantity = 1
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
