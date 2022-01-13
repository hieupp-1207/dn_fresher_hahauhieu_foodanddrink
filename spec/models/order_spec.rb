require "rails_helper"
require "support/factory_bot"

RSpec.describe Order, type: :model do
  subject {create(:order)}

  context "has a valid factory" do
    it {expect(subject).to be_valid}
    it {is_expected.to validate_presence_of(:address)}
    it {is_expected.to validate_presence_of(:phone)}
  end
  
  describe "define status as an enum" do
    it {is_expected.to define_enum_for(:status).
      with([:pending, :rejected, :accept, :delivered])}
  end

  describe "Associations" do
    it {is_expected.to have_many(:order_details).dependent(:destroy)}
    it {is_expected.to belong_to(:user)}
  end

  describe "Delegate" do
    it {is_expected.to delegate_method(:fullname).to(:user).with_prefix}
    it {is_expected.to delegate_method(:email).to(:user).with_prefix}
  end

  describe "#sort_orders" do
    let(:order_1) {create(:order, status: 3)}
    let(:order_2) {create(:order, status: 0)}
    it "order by status asc and created_at desc" do
      expect(Order.sort_orders).to eq([order_2, order_1])
    end
  end

  describe "#update_quantity_product" do
    let(:order_detail_1) {create(:order_detail, order_id: subject.id)}
    let(:order_detail_2) {create(:order_detail, order_id: subject.id)}
    context "when status change to rejected" do
      it "increase product quantity" do
        subject.update!(status: Order.statuses[:rejected])
        subject.update_quantity_product
        subject.order_details.each do |item|
          expect(item.product.quantity).to eq(52)
        end
      end
    end

    context "when status NOT change to rejected" do
      it "NOT change product quantity" do
        subject.update!(status: Order.statuses[:accept])
        subject.update_quantity_product
        subject.order_details.each do |item|
          expect(item.product.quantity).to eq(50)
        end
      end
    end
  end
end
