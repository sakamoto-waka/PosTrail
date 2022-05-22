require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { build(:like) }
  let(:like_user) { create(:user, :like_user) }
  let(:post) { create(:post) }
  describe 'likeモデルに関するテスト' do
    describe 'likeモデルのバリデーション' do
      it 'user_idとpost_idがあれば保存ができること' do
        like.user_id = like_user.id
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
      # it 'user_idが同じでもpost_idが違うと保存できること' do
      #   like = FactoryBot.create(:like)
      #   expect(FactoryBot.create(:like, post_id: like.post_id)).to be_valid
      # end
      # it "post_idが同じでもuser_idが違うと保存できること" do
      #   like = FactoryBot.create(:like)
      #   expect(FactoryBot.create(:like, psot_id: like.post_id)).to be_valid
      # end
      
    end
  end
end

