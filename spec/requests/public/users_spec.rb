require 'rails_helper'

RSpec.describe 'Postsコントローラー', type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }

  describe "newのアクション" do
    it "returns http success" do
      sign_in user
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end
end
