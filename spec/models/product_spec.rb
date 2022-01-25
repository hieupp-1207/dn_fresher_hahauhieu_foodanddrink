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
    end
  end
end
