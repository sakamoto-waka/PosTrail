require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  let(:user) { create(:user) }
  let(:other_user_post) { create(:post, user_id: other_user.id) }
  let(:other_user) { create(:user) }

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
              expect do
                other_user_post.create_notification_like(user)
              end.to change { user.active_notifications.count }.by 1
            end
          end

          context 'other_user_postを自分がいいねしたとき' do
            it 'postのuserのpassive_notificationsが1増えること' do
              expect do
                other_user_post.create_notification_like(user)
              end.to change { other_user.passive_notifications.count }.by 1
            end
            it 'userへの通知のactionがlikeなこと' do
              other_user_post.create_notification_like(user)
              # いいねしているのは自分なのでvisited_idが自分のid
              user_notice = Notification.find_by(visitor_id: user.id)
              expect(user_notice.action).to eq 'like'
            end
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
              expect(user.active_notifications.count).to eq 0
              expect do
                other_user_post.create_notification_comment(user, comment.id)
              end.to change { user.active_notifications.count }.by 1
            end
          end

          context 'other_user_postに自分がコメントしたとき' do
            it 'postのuserのpassive_notificationsが1増えること' do
              expect(other_user.passive_notifications.count).to eq 0
              expect do
                other_user_post.create_notification_comment(user, comment.id)
              end.to change { other_user.passive_notifications.count }.by 1
            end
            it 'userへの通知のactionがcommentなこと' do
              other_user_post.create_notification_comment(user, comment.id)
              user_notice = Notification.find_by(visitor_id: user.id)
              expect(user_notice.action).to eq 'comment'
            end
          end

          context 'other_userからuserへの通知が２回目のとき' do
            it 'active_notificationsは2に増えること' do
              other_user_post.create_notification_comment(user, comment.id)
              other_user_post.create_notification_comment(user, comment.id)
              expect(user.active_notifications.count).to eq 2
            end
          end

          context '自分の投稿にコメントしたとき' do
            it 'active_notificationsは1増えること' do
              other_user_post.create_notification_comment(other_user, comment.id)
              expect(other_user.active_notifications.count).to eq 1
            end
          end
        end
      end

      describe 'save_tag(sent_tags)のテスト' do
        context 'タグが保存されるとき' do
          it 'タグが一つであること' do
            sent_tags = 'タグ'
            expect do
              post.save_tag(sent_tags)
            end.to change { Tag.count }.by 1
          end
          it 'タグが半角スペースで区切られていること' do
            sent_tags = 'タグ1 タグ2'
            expect do
              post.save_tag(sent_tags)
            end.to change { Tag.count }.by 2
          end
          it 'タグが全角スペースで区切られていること' do
            sent_tags = 'タグ1  タグ2'
            expect do
              post.save_tag(sent_tags)
            end.to change { Tag.count }.by 2
          end
          context 'タグが,で区切られているとき' do
            it 'タグは１つとして保存されていること' do
              sent_tags = 'タグ1,タグ2'
              expect do
                post.save_tag(sent_tags)
              end.to change { Tag.count }.by 1
            end
          end
        end

        context 'タグが保存されないとき' do
          context '同じタグを保存するとき' do
            it 'タグのカウントが増えないこと' do
              sent_tags = 'タグ1'
              post.save_tag(sent_tags)
              expect(Tag.count).to eq 1
              expect do
                post.save_tag(sent_tags)
              end.to change { Tag.count }.by 0
            end
          end

          context '1回目に2つのタグ、２回目に同じタグと違うタグの2つのタグがあるとき' do
            it 'タグのカウントが3になること' do
              sent_tags1 = 'タグ1 タグ2'
              sent_tags2 = 'タグ2 タグ3'
              post.save_tag(sent_tags1)
              expect(Tag.count).to eq 2
              post.save_tag(sent_tags2)
              expect(Tag.count).to eq 3
            end
          end
        end
      end

      describe 'looksのテスト' do
        let(:search_post) { create(:post, body: '検索中') }

        context '検索中でlooks(検索)した場合' do
          it 'postを返すこと' do
            expect(Post.looks('検索中')).to include(search_post)
          end
          it 'other_user_postは返さないこと' do
            expect(Post.looks('検索中')).not_to include(other_user_post)
          end
        end

        context 'テストでlooks(検索)した場合' do
          it 'post(bodyがテストの投稿です)を返すこと' do
            expect(Post.looks('テストの投稿です')).to include(post)
            expect(Post.looks('テスト')).to include(post)
          end
        end

        context '「空を期待」でlooks検索した場合' do
          it '「空を期待」でlooks(検索)すると空を返すこと' do
            expect(Post.looks('空を期待')).to be_empty
          end
        end
      end
      describe 'written_by?(current_user)のテスト' do
        context 'other_user_post.userがother_userと同じとき' do
          it 'trueが返ること' do
            expect(other_user_post.written_by?(other_user)).to be_truthy
          end
        end
        context 'other_user_post.userがother_userと違うとき' do
          it 'falseが返ること' do
            expect(other_user_post.written_by?(user)).to be_falsey
          end
        end
      end
      describe 'search_prefectureのテスト' do
        context '1を渡したとき' do
          it '北海道を持つpostsの配列が取れること' do
          end
        end
      end
    end
  end
end
