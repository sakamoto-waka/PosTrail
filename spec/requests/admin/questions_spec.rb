require 'rails_helper'

RSpec.describe "Admin::Questions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/questions"
      expect(response).to have_http_status(:success)
    end
  end
end
