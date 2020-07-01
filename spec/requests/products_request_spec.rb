require 'rails_helper'

RSpec.describe Shops::ProductsController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:color) {FactoryBot.create :color}
  let!(:category) {FactoryBot.create :category}
  let!(:brand) {FactoryBot.create :brand}
  let(:product) {FactoryBot.create :product, user: user}
  let(:product_colors) {FactoryBot.create :product_color}

  context "when shop login" do
    before {login user}

    describe "GET #index" do
      before {get :index}
      it "list all products" do
        expect(assigns(:products)).to eq([product])
      end
      it "render the index view" do
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      before {get :new}

      it "assigns a new Product to @product" do
        expect(assigns(:product)).to be_a_new(Product)
      end
      it "render the new view" do
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      subject {
        post :create, params: {
          product: FactoryBot.attributes_for(
            :product,
            user: current_user.id,
            brand: brand,
            category: category
          ),
          product_color: FactoryBot.attributes_for(
            :product_color,
            product: product,
            color: color
          )
        }
      }

      context "with valid attributes" do
        it "create a new product success" do
          expect {subject}.to change(Product, :count).by(1)
        end
      end
      context "with invalid attributes" do
        it "create a new product fail" do
          expect(subject).not_to eq(0)
        end
      end
    end

    describe "GET #edit" do
      context "with valid product" do
        it "find product & render view edit template" do
          get :edit, params: {slug: product.slug}
          expect(response).to render_template :edit
        end
      end
      context "with invalid product" do
        it "not find product & redirect to shops_products_path" do
          get :edit, params: {slug: "product-abc-xyz"}
          expect(response).to redirect_to shops_products_path
        end
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "update success & redirect to shops_products_path" do
          patch :update, params: {slug: product.slug, product: {name: "Product edit"}}
          expect(response).to redirect_to shops_products_path
        end
      end
      context "with invalid attributes" do
        it "update fail & render view edit" do
          patch :update, params: {slug: product.slug, product: {name: ""}}
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      context "with valid product" do
        it "delete success & show flash message" do
          delete :destroy, params: {slug: product.slug, product: {deleted_at: Time.now}}
          expect(flash[:success]).to match I18n.t("shop.product.index.delete_success")
        end
      end
      context "with invalid product" do
        it "delete fail & show flash message" do
          delete :destroy, params: {slug: "abc-xyz", product: {deleted_at: Time.now}}
          expect(flash[:warning]).to match I18n.t("shop.product.not_exist_product")
        end
      end
    end
  end
end
