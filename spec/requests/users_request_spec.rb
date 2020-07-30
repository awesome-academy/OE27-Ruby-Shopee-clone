require "rails_helper"

RSpec.describe Users::UsersController, type: :controller do

  describe "GET #new" do
    before do
      get :new
    end

    it "should redirect to login page" do
      expect(response).to render_template(:new)
    end

    it "should found" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "create user successfully" do
      let!(:user) {FactoryBot.create :user}

      before do
        post :create, params: {user: FactoryBot.attributes_for(:user)}
      end

      it "create user successfully" do
        expect(response).to have_http_status(302)
      end

      it "flash create user successfully" do
        expect(flash[:info]).to match(I18n.t("home.sign_up.success"))
      end

      it "test number of user" do
        expect{
          post :create, params: {user: FactoryBot.attributes_for(:user)}
        }.to change(User, :count).by(1)
      end
    end

    context "create user failed" do
      before do
        post :create, params: {user: {username: "!123", email: "@"}}
      end

      it "create user failed" do
        expect(response).to render_template(:new)
      end

      it "flash now create user failed" do
        expect(flash.now[:danger]).to match(I18n.t("home.sign_up.fail"))
      end
    end
  end
end
