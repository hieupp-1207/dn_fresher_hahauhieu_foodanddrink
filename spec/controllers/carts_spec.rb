require "rails_helper"
include SessionsHelper

RSpec.describe CartsController, type: :controller do
  let!(:product) {FactoryBot.create :product}

  describe "GET #index" do
    before do
      session[:cart] = {}
      current_cart[product.id.to_s] = 2
      @products = Product.by_ids load_products_in_cart
      @subtotal_in_cart = subtotal @products
      get :index
    end

    it "check products in cart" do
      expect(assigns(:products)).to eq @products
    end

    it "check subtotal in art" do
      expect(assigns(:subtotal_in_cart)).to eq @subtotal_in_cart
    end

    it "renders the index template" do
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    context "add product to cart success" do
      before do
        session[:cart] = {}
        post :create, params: {product_id: product.id, quantity: 2}
      end

      it "product in cart" do
        expect(current_cart[product.id.to_s]).to eq 2
      end

      it "show flash message" do
        expect(flash[:success]).to eq I18n.t("carts.create.add_success")
      end

      it "redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "quantity of product is not enough" do
      before do
        session[:cart] = {}
        post :create, params: {product_id: product.id, quantity: 10000}
      end

      it "show flash message" do
        expect(flash[:danger]).to eq I18n.t("errors.not_enough")
      end

      it "redirect to product path" do
        expect(response).to redirect_to product_path product.id
      end
    end

    context "not found product" do
      before do
        session[:cart] = {}
        post :create, params: {product_id: 0, quantity: 1}
      end

      it "show flash message" do
        expect(flash[:danger]).to eq I18n.t("errors.not_found_product")
      end

      it "redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      session[:cart] = {}
      current_cart[product.id.to_s] = 2
      delete :destroy, params: {id: product.id}
    end
    it "delete item cart success" do
      expect(current_cart[product.id.to_s].nil?).to eq true
    end

    it "show flash message" do
      expect(flash[:success]).to eq I18n.t("carts.destroy.delete_success")
    end

    it "redirect to carts path" do
      expect(response).to redirect_to carts_path
    end
  end

  describe "GET #reset" do
    before do
      session[:cart] = {}
      current_cart[product.id.to_s] = 2
      get :reset
    end

    it "reset items cart success" do
      expect(current_cart.empty?).to eq true
    end

    it "redirect to carts path" do
      expect(response).to redirect_to carts_path
    end

    it "show flash message" do
      expect(flash[:success]).to eq I18n.t("carts.reset.reset_success")
    end
  end
end
