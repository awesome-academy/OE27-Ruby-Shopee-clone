require "rails_helper"

RSpec.describe Order, type: :model do
  let!(:order) {FactoryBot.create :order}
  let!(:order_item) {FactoryBot.create :order_item, order_id: order.id}
  let!(:user) {FactoryBot.create :user}

  describe "Associations" do
    it {expect(order).to have_many(:order_items)}
    it {expect(order).to belong_to(:user)}
  end

  context "Scopes" do
    describe ".by_status" do
      subject{Order.by_status(Order.statuses[:pending]).first.status}

      it "with status is pending" do
        expect(subject).to eq("pending")
      end
      it "with status is not pending" do
        expect(subject).not_to eq("checked")
      end
    end

    describe ".search_by_id" do
      it "when search order existed" do
        expect(Order.search_by_id(order.id).first.id).to eq(order.id)
      end
      it "when search order not existed" do
        expect(Order.search_by_id(2234234234).first).not_to eq(order)
      end
    end
  end

  describe "Delegate" do
    it {should delegate_method(:name).to(:user).with_prefix(true)}
    it {should delegate_method(:phone).to(:user).with_prefix(true)}
  end

  describe "Nested attributes" do
    it {expect(order).to accept_nested_attributes_for(:order_items)}
  end

  describe "#subtotal" do
    subject{Order.first.subtotal}

    it "with correct subtotal" do
      expect(subject).to eq(500)
    end
    it "with incorrect subtotal" do
      expect(subject).not_to eq(600)
    end
  end
end
