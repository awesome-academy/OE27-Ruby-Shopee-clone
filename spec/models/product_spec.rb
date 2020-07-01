require "rails_helper"

RSpec.describe Product, type: :model do
  let!(:product) {FactoryBot.create :product, name: "Product test rspec"}
  let!(:order_item) {FactoryBot.create :order_item}
  let!(:color) {FactoryBot.create :color}
  let!(:product_color) {FactoryBot.create :product_color, color_id: color.id, product_id: product.id}
  let(:product_validate) {
    FactoryBot.build :product,
      name: "",
      price: "",
      brand_id: "",
      category_id: "",
      user_id: "",
      description: "",
      created_at: Time.now,
      updated_at: Time.now
  }

  describe Product do
    describe "Associations" do
      it {expect(product).to have_many(:product_colors)}
      it {expect(product).to have_many(:colors)}
      it {expect(product).to have_many(:images)}
      it {expect(product).to have_many(:order_items)}
      it {expect(product).to belong_to(:user)}
      it {expect(product).to belong_to(:category)}
      it {expect(product).to belong_to(:brand)}
    end

    describe "Validations" do
      context "Product validations" do
        it {expect(product_validate).to validate_presence_of(:name)}
        it {expect(product_validate).to validate_length_of(:name).is_at_least(20).is_at_most(255)}
        it {expect(product_validate).to validate_presence_of(:brand_id)}
        it {expect(product_validate).to validate_presence_of(:category_id)}
        it {expect(product_validate).to validate_presence_of(:user_id)}
        it {expect(product_validate).to validate_numericality_of(:price)}
        it {expect(product_validate).not_to validate_inclusion_of(:price).in_range(Settings.shop.price_min..Settings.shop.price_max)}
      end
    end

    context "Scopes" do
      describe ".price_range" do
        it "with price in range 80 to 120" do
          expect(Product.price_range(80, 120).first.price).to be_within(20).of(100)
        end
        it "with price out range 80 to 120" do
          expect(Product.price_range(80, 120).first.price).not_to be_within(20).of(100)
        end
      end

      describe ".total_money" do
        it "with correct total money" do
          expect(Product.includes(:order_items).total_money).to eq(500)
        end
        it "with incorrect total money" do
          expect(Product.includes(:order_items).total_money).not_to eq(500)
        end
      end

      describe ".search" do
        it "when search product existed" do
          expect(Product.search("Product").eager_load(:brand, :category).first).to eq(product)
        end
        it "when search product not existed" do
          expect(Product.search("123qwe").eager_load(:brand, :category).first).not_to eq(product)
        end
      end

      describe ".by_color" do
        it "when search exist color" do
          expect(Product.by_color(1).first).to eq(product)
        end
        it "when search not exist color" do
          expect(Product.by_color(2).first).not_to eq(product)
        end
      end
    end
  end
end
