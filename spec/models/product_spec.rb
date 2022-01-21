require 'rails_helper'

RSpec.describe Product, type: :model do
  describe ".newest" do
    it "orders by created_at desc" do
      category = Category.create! name: "aaaaaa"
      product_1 = category.products.create(name: "first product",
                                description: "asd",
                                image: "asd",
                                price: 11,
                                quantity: 11,
                                rating: 1)
      product_2 = category.products.create(name: "second product",
                                description: "asd",
                                image: "asd",
                                price: 11,
                                quantity: 11,
                                rating: 1)
      expect(Product.newest).to eq([product_2, product_1])
    end
  end

  describe ".limit_8" do
    it "select only 8 products" do
      category = Category.create! name: "aaaaaa"
      30.times do |n|
        name = Faker::Food.fruits
        description = "example-#{n+1}@railstutorial.org"
        image = "banner.jpg"
        price = Faker::Number.decimal(l_digits: 5, r_digits: 2)
        quantity = 50
        rating = 1
        category.products.create!(name: name,
                        description: description,
                        image: image,
                        price: price,
                        quantity: quantity,
                        rating: rating)
      end
      expect(Product.limit_8.count).to eq(8)
    end
  end
end
