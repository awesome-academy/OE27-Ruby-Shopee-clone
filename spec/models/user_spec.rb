require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.build :user, email: "BUIVANSAOBG@GMAIL.COM"}

  describe "#email_downcase" do
    context "when user sign up" do
      it "downcase email" do
        expect(user.send(:email_downcase)).to eq("buivansaobg@gmail.com")
      end
      it "not downcase email" do
        expect(user.send(:email_downcase)).not_to eq("BUIVANSAOBG@GMAIL.COM")
      end
    end
  end
end
