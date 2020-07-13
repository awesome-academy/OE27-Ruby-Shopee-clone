require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /product_colors" do
    it "returns http success" do
      get "/users/product_colors"
      expect(response).to have_http_status(:success)
    end
  end

end
