require 'rails_helper'

RSpec.describe Product, type: :model do
  describe ".newest" do
    it "orders by created_at desc" do
      category = create(:category)
      product_1 = create(:product ,category_id: category.id)
      product_2 = create(:product ,category_id: category.id)
      expect(Product.newest).to eq([product_2, product_1])
    end
  end

  describe ".limit_8" do
    it "select only 8 products" do
      category = Category.create! name: "aaaaaa"
      30.times do |n|
        create(:product ,category_id: category.id)
      end
      expect(Product.limit_8.count).to eq(8)
  describe "#by_ids" do
    it "search product by id exist" do
      category = Category.create! name: "thit"
      product = category.products.create(name: "name product")

      expect(Product.by_ids(product.id)).to include product
    end
    it "search product by id not exist" do
      expect(Product.by_ids("")).to eq []
    end
  end

  describe "#search" do
    it "search product by name exist" do
      category = Category.create! name: "thit"
      product_1 = category.products.create(name: "name product 1")
      product_2 = category.products.create(name: "name product 2")

      expect(Product.search("name")).to include [product_1, product_2]
    end
  end
end
