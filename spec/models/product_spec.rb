require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product_1) {FactoryBot.create :product, name: "banana"}
  let!(:product_2) {FactoryBot.create :product, name: "apple"}

  describe ".newest" do
    it "orders by created_at desc" do
      expect(Product.newest).to eq([product_2, product_1])
    end
  end

  describe ".limit_8" do
    it "select only 8 products" do
      30.times do |n|
        create(:product)
      end
      expect(Product.limit_8.count).to eq(8)
    end
  end

  describe "#by_ids" do
    it "search product by id exist" do
      expect(Product.by_ids(product_1.id)).to include product_1
    end
    it "search product by id not exist" do
      expect(Product.by_ids("asdasd")).to eq []
    end
  end

  describe "#search" do
    it "search product by name exist" do
      expect(Product.search("banana")).to eq [product_1]
    end
    it "search product by name not exist" do
      expect(Product.search("abcxyz")).to eq []
    end
  end
end
