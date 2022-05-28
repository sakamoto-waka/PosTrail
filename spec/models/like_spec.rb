require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like) { build(:like) }

  describe 'likeモデルに関するテスト' do
    describe 'likeモデルのバリデーション' do
      it 'user_idとpost_idがあれば保存ができること' do
        like.user_id = user.id
        like.post_id = post.id
        expect(like).to be_valid
      end
      it 'user_idがなければ無効なこと' do
        like.user_id = nil
        expect(like).to be_invalid
        expect(like.errors[:user_id]).to include('を入力してください')
      end
      it 'post_idがなければ無効なこと' do
        like.post_id = nil
        expect(like).to be_invalid
        expect(like.errors[:post_id]).to include('を入力してください')
      end
    end
  end
end
