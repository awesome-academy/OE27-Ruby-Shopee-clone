require "rails_helper"

RSpec.describe Rating, type: :model do
  let!(:product) {FactoryBot.create :product, count_rate: 10, total_star: 50, avg_star: 5}
  let!(:rating) {FactoryBot.create :rating, product_id: product.id, user_id: user.id}
  let!(:user) {FactoryBot.create :user}

  describe "Associations" do
    it {expect(rating).to belong_to(:product)}
    it {expect(rating).to belong_to(:user)}
  end

  describe "#save" do
    it "when update star after save" do
      expect(rating).to receive(:update_star)
      rating.run_callbacks(:save)
    end
  end
end
