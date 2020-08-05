require "rails_helper"

RSpec.describe ProductColor, type: :model do
  let!(:product) {FactoryBot.create :product_color}
  let!(:order_item) {FactoryBot.create :order_item}
  let!(:color) {FactoryBot.create :color}
  let!(:product_color) {FactoryBot.create :product_color, color_id: color.id, product_id: product.id}
  let(:product_color_validate) {
    FactoryBot.build :product_color,
      quantity: "",
      product_id: "",
      color_id: "",
      created_at: Time.now,
      updated_at: Time.now
  }

  describe ProductColor do
    describe "Associations" do
      it {expect(product_color).to belong_to(:product)}
      it {expect(product_color).to belong_to(:color)}
    end

    describe "Validations" do
      context "ProductColor validations" do
        it {expect(product_color_validate).to validate_presence_of(:quantity)}
        it {expect(product_validate).to validate_presence_of(:product_id)}
        it {expect(product_validate).to validate_presence_of(:color_id)}
        it {expect(product_color_validate).not_to validate_inclusion_of(:quantity).in_range(Settings.shop.price_min..Settings.shop.price_max)}
      end
    end

    context "Scopes" do
      describe ".select_color" do
        it "with color existed" do
          expect(ProductColor.select_color(product_color.color_id).first.color_id).to eq(product_color.color_id)
        end
        it "with color not existed" do
          expect(ProductColor.select_color(2234234234).first).not_to eq(product_color)
        end
      end

      describe ".by_ids" do
        it "when search product color existed" do
          expect(ProductColor.by_ids(product_color.id).first.id).to eq(product_color.id)
        end
        it "when search order not existed" do
          expect(ProductColor.by_ids(2234234234).first).not_to eq(product_color)
        end
      end

      describe ".by_color" do
        it "when search exist color" do
          expect(ProductColor.by_color(product_color.color_id).first.color_id).to eq(product_color.color_id)
        end
        it "when search not exist color" do
          expect(ProductColor.by_color(2234234234).first).not_to eq(product_color)
        end
      end

      describe ".by_product" do
        it "when product exist color" do
          expect(ProductColor.by_product(product_color.product_id).first.product_id).to eq(product_color.product_id)
        end
        it "when search not exist product" do
          expect(ProductColor.by_product(2234234234).first).not_to eq(product_color)
        end
      end
    end
  end
end
