require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { build(:like) }
  let(:like_user) { create(:user, :like_user) }
  let(:post) { create(:post) }
  describe 'いいね機能に関するテスト' do
    describe 'likeモデルのバリデーション' do
      context 'user_idとpost_idがあるとき' do
        it '保存ができること' do
          like.user_id = like_user.id
          like.post_id = post.id
          expect(like).to be_valid
        end
      end
    end
  end
end
