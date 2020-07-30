require "rails_helper"

RSpec.describe Users::ReviewsController, type: :controller do
  let(:review){FactoryBot.create :review}
  let!(:user){FactoryBot.create :user}

  context "when logined" do
    before {login user}

    describe "POST #create" do
      before{post :create, params: {review: FactoryBot.attributes_for(:review)}}

      context "with valid attributes" do
        it "creates a new comment" do
          expect{review}.to change{Review.count}.by(1)
        end
      end

      it "redirects to the new comment" do
        is_expected.to respond_with(204)
      end
    end

    context "with invalid attributes" do
      it "does not save the new comment" do
        expect{ post :create, params: {review: FactoryBot.attributes_for(:review) }}
          .to_not change(Review,:count)
      end
    end
  end

  context "when not login" do
    describe "POST #create" do
      it "Not allow" do
        post :create, params: {review: FactoryBot.attributes_for(:review)}
        expect(response).to redirect_to login_path
      end
    end
  end
end
