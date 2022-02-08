require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user_1) {FactoryBot.create :user, email: "ai@gmail.com"}

  describe "association" do
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_many(:ratings).dependent(:destroy) }
  end

  describe "validate password" do
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe "validate email" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value("admin@gmail.com").for(:email) }
    it { is_expected.to_not allow_value("foo").for(:email) }
  end
end
