require "rails_helper"
require "support/factory_bot"
include SessionsHelper

RSpec.describe Admin::OrdersController, type: :controller do
  describe "GET/index" do
    context "when login as admin" do
      let!(:orders) {create_list(:order,3)}
      before do
        user = FactoryBot.create(:user, role: 1)
        log_in user
        get :index
      end
      
      it "assigns orders" do
        expect(assigns(:orders).count).to eq(orders.count)
      end

      it "render index view" do
        expect(response).to render_template("index")
      end
    end

    context "when not login as admin" do
      before do
        user = FactoryBot.create(:user)
        log_in user
        get :index
      end

      it "show message danger" do
        expect(flash[:danger]).to eq I18n.t("admin.orders.index.forbiden")
      end

      it "redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH/update" do
    context "success when attributes is valid" do
      let!(:user) {create(:user, role: 1)}
      let!(:order) {create(:order, user_id: user.id, status: 0)}
      let(:stub_referer) {admin_orders_path}

      before do
        log_in user
        request.headers.merge! referer: stub_referer    
        patch :update, params: {
          id: order.id,
          status: "2"
        }
        order.reload
      end

      it "update db success" do
        expect(order.status).to eq(Order.statuses.keys[2])
      end

      it "redirect to index page" do
        expect(response).to redirect_to admin_orders_path
      end
    end

    context "fail when attributes invalid" do
      let!(:user) {create(:user, role: 1)}
      let!(:order) {create(:order, user_id: user.id, status: 2)}
      let(:stub_referer) {admin_orders_path}
      before do
        log_in user
        patch :update, params: {
          id: order.id,
          status: "0"
        }
      end

      it "show message danger" do
        expect(flash[:danger]).to eq I18n.t("admin.orders.update.update_status_invalid")
      end

      it "redirect to index page" do
        expect(response).to redirect_to(admin_orders_path)
      end
    end

    context "fails when params[:id] not found" do
      let!(:user) {create(:user, role: 1)}
      let!(:order) {create(:order, user_id: user.id, status: 2)}
      before do
        log_in user
        patch :update, params: {
          id: -1,
          status: "0"
        }
      end

      it "show message danger" do
        expect(flash[:danger]).to eq I18n.t("admin.orders.update.not_found_order")
      end

      it "redirect to order index page" do
        expect(response).to redirect_to(admin_orders_path)
      end
    end
  end
end
