require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do

  let!(:products) {FactoryBot.create_list(:product, 10)}

  describe "GET #home" do

    before do
      get :home
    end
    it "assigns products" do
      expect((assigns :products).count).to eq 8
    end

    it "returns a success response" do
      expect(response).to render_template("home")
    end
  end
end
