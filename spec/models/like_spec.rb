require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { build(:like) }
  let(:like_user) { create(:user, :like_user) }
  let(:post) { create(:post) }
  describe 'いいね機能に関するテスト' do
    describe 'likeモデルのバリデーション' do
      it 'user_idとpost_idがあれば保存ができること' do
        like.user_id = like_user.id
        like.post_id = post.id
        expect(like).to be_valid
      end
      it 'user_idがなければ無効なこと' do
        like.user_id = nil
        like.post_id = post.id
        expect(like).to be_invalid
        expect(like.errors[:user_id]).to include('を入力してください')
      end
    end
  end
end
