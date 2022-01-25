require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    let!(:products) {FactoryBot.create_list(:product, 10)}

    context "when product empty" do
      before{get :index, params: {term: "11111111111"}}


      it "redirect to products path" do
        expect(response).to redirect_to products_path
      end

      it "show flash message" do
        expect(flash[:danger]).to eq I18n.t("errors.not_found_product")
      end
    end

    context "when product exist" do
      before{get :index, params: {term: "a"}}

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "assigns products" do
        expect((assigns :products).count).to eq products.count
      end
    end
  end

  describe "GET #show" do
    let!(:product) {FactoryBot.create :product}

    context "when product exist" do
      before{get :show, params: {id: product}}

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "assigns product" do
        expect(assigns :product).to eq product
      end
    end

    context "when product not found" do
      before{get :show, params: {id: 0}}

      it "redirect to products path" do
        expect(response).to redirect_to root_path
      end

      it "show flash message" do
        expect(flash[:danger]).to eq I18n.t("errors.not_found_product")
      end
    end
  end
end
