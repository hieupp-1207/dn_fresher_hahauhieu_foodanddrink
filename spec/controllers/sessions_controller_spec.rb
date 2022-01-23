require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:user_admin) {FactoryBot.create :user, role: 1}

  describe "GET #new" do
    subject {get :new}
    it "render new template" do
      expect(subject).to render_template(:new)
    end
    it "does not render different template" do
      expect(subject).to_not render_template(:show)
    end
  end

  describe "POST #create" do
    context "when valid params and account is user" do
      before do
        post :create, params: { session: {
          email: user.email,
          password: user.password,
        }}
      end

      it "login user" do
        expect(session[:user_id]).to eq user.id
      end
      it "display flash message success" do
        expect(flash[:success]).to eq I18n.t("sessions.create.login_success")
      end
      it "redirects to the root_url" do
        expect(response).to redirect_to root_url
      end
    end

    context "when valid params and account is admin" do
      before do
        post :create, params: { session: {
          email: user_admin.email,
          password: user_admin.password,
        }}
      end

      it "login user" do
        expect(session[:user_id] = user_admin.id)
      end
      it "display flash message success" do
        expect(flash[:success]).to eq I18n.t("sessions.create.login_success")
      end
      it "redirects to the root_url" do
        expect(response).to redirect_to admin_root_url
      end
    end

    context "when invalid params" do
      before do
        post :create, params: { session: {
          email: "zxczxc@gmail.com",
          password: "123123123",
        }}
      end
      it "display flash message fail" do
        expect(flash[:warning]).to eq I18n.t("sessions.create.login_fail")
      end
      it "render new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #destroy" do
    before do
      post :destroy, params: { session: {
        email: user.email,
        password: user.password,
      }}
    end
    subject {get :destroy}
    it "redirects to the root_url" do
      expect(subject).to redirect_to root_url
    end
    it "delete session" do
      expect(session[:user_id]).to be nil
    end
    it "current user is nil" do
      expect(@current_user).to  be nil
    end
  end
end
