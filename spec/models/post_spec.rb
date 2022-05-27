require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post) { create(:post) }
  let!(:user) { create(:user) }
  describe 'モデルに関するテスト' do
    describe 'バリデーションのテスト' do
      context '成功するとき' do
        it 'body, prefecture_idがあれば有効であること' do
          expect(post).to be_valid
        end
        it '画像が有効なこと' do
          post.trail_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test1.png'))
          expect(post).to be_valid
        end
      end
      context '失敗するとき' do
        it 'bodyがないと無効であること' do
          post.body = ''
          expect(post).to be_invalid
        end
        it 'prefecture_idがないと無効であること' do
          post.prefecture_id = nil
          expect(post).to be_invalid
        end
        it 'trail_placeが26文字であれば無効であること' do
          post.trail_place = 'a' * 26
          expect(post).to be_invalid
        end
        it 'bodyが201文字であれば無効であること' do
          post.body = 'a' * 201
          expect(post).to be_invalid
        end
      end
    end
    describe 'メソッドのテスト' do
      describe 'liked_by?(user)のテスト'
      # let(:like) { create(:like) }
        context 'userがいいねをしているとき' do
          it 'trueが返ること' do
            expect(user.liked_by?).to be_truthy
          end
        end
        context 'userがいいねをしていないとき' do
          it 'flaseが返ること' do
          
        end
      end
    end
  end
end
