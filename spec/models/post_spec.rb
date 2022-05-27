require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:other_user_post) { create(:post, user_id: other_user.id) }
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
        context 'userがいいねをしているとき' do
        let!(:like) { create(:like, post_id: post.id, user_id: user.id) }
          it 'trueが返ること' do
            expect(post.liked_by?(user)).to be_truthy
          end
        end
        context 'userがいいねをしていないとき' do
        let!(:like) { create(:like, post_id: post.id) }
          it 'flaseが返ること' do
            expect(post.liked_by?(user)).to be_falsey
        end
      end
      describe 'create_notification_like(current_user)のテスト' do
        context '通知が作成されるとき' do
          context 'userへの通知が初めてのとき' do
            it 'userのactive_notificationsが1増えること' do
              expect(user.active_notifications.count).to eq 0
              expect{
                other_user_post.create_notification_like(user)
              }.to change{ user.active_notifications.count }.by 1
            end
          end
          context 'other_userいいねしたとき' do
            it 'postのuserのpassive_notificationsが1増えること' do
              expect{
                other_user_post.create_notification_like(user)
              }.to change{ other_user.passive_notifications.count }.by 1
            end
          end
          it 'userへの通知のactionがlikeなこと' do
            other_user_post.create_notification_like(user)
            # いいねしているのは自分なのでvisited_idが自分のid
            user_notice = Notification.find_by(visitor_id: user.id)
            expect(user_notice.action).to eq 'like'
          end
        end
        context '通知が作成されないとき' do
          context 'other_userからuserへの通知が初めてではないとき' do
            it 'active_notificationsは1のまま増えないこと' do
              other_user_post.create_notification_like(user)
              other_user_post.create_notification_like(user)
              expect(user.active_notifications.count).to eq 1
            end
          end
          context '自分の投稿にいいねしたとき' do
            it 'active_notificationsは1のまま増えないこと' do
              other_user_post.create_notification_like(other_user)
              expect(user.active_notifications.count).to eq 0
            end
          end
        end
      end
      describe 'create_notification_comment(current_user, comment_id)のテスト' do
        let(:comment) { create(:comment, post_id: post.id, user_id: other_user.id) }
        context '通知が作成されるとき' do
          context 'userへの通知が初めてのとき' do
            it 'userのactive_notificationsが1増えること' do
              other_user_post.create_notification_comment(user, comment.id)
              expect(user.active_notifications.count).to eq 1
            end
          end
        end
      end
    end
  end
end
