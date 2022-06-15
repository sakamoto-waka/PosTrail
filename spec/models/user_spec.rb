require 'rails_helper'

RSpec.describe 'ユーザーモデル', type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, :other_user) }

  describe 'モデルに関するテスト' do
    it 'name, email, password, encrypted_passwordがあれば有効なこと' do
      expect(user).to be_valid
    end
    it 'アカウント画像が有効なこと' do
      user.account_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test1.png'))
      expect(user).to be_valid
    end
    it 'nameがないと無効になること' do
      user.name = nil
      expect(user).to be_invalid
    end
    it 'nameは15文字以下は無効になること' do
      user.name = 't' * 16
      expect(user).to be_invalid
    end
    it 'nameは2文字以下は無効になること' do
      user.name = 't'
      expect(user).to be_invalid
    end
    it 'emailがなければ無効になること' do
      user.email = nil
      expect(user).to be_invalid
    end
    it 'emailが重複してたら無効' do
      other_user.email = user.email
      expect(other_user).to be_invalid
    end
    it 'passwordがなければ無効になること' do
      user.password = ''
      expect(user).to be_invalid
    end
    it 'passwordが暗号化されてること' do
      expect(user.encrypted_password).not_to eq user.password
    end
    it 'introductionが201文字であれば無効になること' do
      user.introduction = 'あ' * 201
      expect(user).to be_invalid
    end
  end

  describe 'メソッドに関するテスト' do
    describe 'active_for_authentication?のテスト' do
      context 'userのis_deleted == falseのとき' do
        it 'trueが返ってくること' do
          expect(user.active_for_authentication?).to eq true
        end
      end
    end

    describe ' deleted_user_change_nameのテスト' do
      context 'userのis_deleted == trueのとき' do
        before { user.is_deleted = true }

        it 'nameが退会済みユーザーになること' do
          user.deleted_user_change_name
          expect(user.name).to eq('退会済みユーザー')
        end
        it '元のnameと一致しないこと' do
          user.name = '元の名前'
          user.deleted_user_change_name
          expect(user.name).not_to eq('元の名前')
        end
      end

      context 'userのis_deleted == falseのとき' do
        before { user.is_deleted = false }

        it 'nameが退会済みユーザーに変わらないこと' do
          user.deleted_user_change_name
          expect(user.name).not_to eq('退会済みユーザー')
        end
        it '元のnameと一致すること' do
          user.name = '元の名前'
          user.deleted_user_change_name
          expect(user.name).to eq('元の名前')
        end
      end
    end

    describe 'looksのテスト' do
      context 'たろうでlooks(検索)した場合' do
        it 'userを返すこと' do
          expect(User.looks('たろう')).to include(user)
        end
        it 'other_userは返さないこと' do
          expect(User.looks('たろう')).not_to include(other_user)
        end
      end

      context 'じろうでlooks検索した場合' do
        it 'じろうでlooks(検索)すると空を返すこと' do
          expect(User.looks('じろう')).to be_empty
        end
      end
    end

    describe 'フォロー機能のテスト' do
      describe 'followのテスト' do
        context 'フォローするとき' do
          it 'userのrelationshipsが1増えること' do
            expect(user.relationships.count).to eq(0)
            expect do
              user.follow(other_user.id)
            end.to change { user.relationships.count }.by(1)
          end
          it 'other_userのrelationshipsは増えないこと' do
            expect do
              user.follow(other_user.id)
            end.to change { other_user.relationships.count }.by(0)
          end
        end
      end

      describe 'unfollowのテスト' do
        context 'フォローを外すとき' do
          it 'userのrelationshipsが1減ること' do
            expect do
              user.follow(other_user.id)
            end.to change { user.relationships.count }.by(1)
            expect do
              user.unfollow(other_user.id)
            end.to change { user.relationships.count }.by(-1)
          end
        end
      end

      describe 'following?のテスト' do
        context 'other_userをフォローしているとき' do
          it 'trueが返ること' do
            user.follow(other_user.id)
            expect(user.following?(other_user)).to be_truthy
          end
        end

        context 'other_userをフォローしていないとき' do
          it 'falseが返ること' do
            expect(user.following?(other_user)).to be_falsey
          end
        end
      end

      describe 'follower?のテスト' do
        context 'other_userがuserをフォローしているとき' do
          it 'trueが返ること' do
            other_user.follow(user.id)
            expect(user.follower?(other_user)).to be_truthy
          end
        end

        context 'other_userがuserをフォローしていないとき' do
          it 'falseが返ること' do
            expect(user.follower?(other_user)).to be_falsey
          end
        end
      end
    end

    describe 'create_notification_follow(current_user)のテスト' do
      context '通知が作成されるとき' do
        context 'other_userからuserへの通知が初めてのとき' do
          it 'userのactive_notificationsが1増えること' do
            expect(user.active_notifications.count).to eq 0
            expect do
              other_user.create_notification_follow(user)
            end.to change { user.active_notifications.count }.by 1
          end
          it 'other_userのpassive_notificationsが1増えること' do
            expect do
              other_user.create_notification_follow(user)
            end.to change { other_user.passive_notifications.count }.by 1
          end
          it 'userへの通知のactionがfollowingなこと' do
            other_user.create_notification_follow(user)
            user_notice = Notification.find_by(visitor_id: user.id)
            expect(user_notice.action).to eq 'following'
          end
        end
      end

      context '通知が作成されないとき' do
        context 'other_userからuserへの通知が初めてではないとき' do
          it 'active_notificationsは1のまま増えないこと' do
            other_user.create_notification_follow(user)
            other_user.create_notification_follow(user)
            expect(user.active_notifications.count).to eq 1
          end
        end
      end
    end

    describe 'self.guestのテスト' do
      context 'ゲストユーザーが未作成のとき' do
        it 'ゲストユーザーが作られること' do
          expect do
            User.guest
          end.to change { User.count }.by(1)
        end
      end

      context 'ゲストユーザーが作成済みのとき' do
        it 'ゲストユーザーが作られないこと' do
          User.guest
          expect do
            User.guest
          end.to change { User.count }.by(0)
        end
      end
    end

    describe 'same?(current_user)のテスト' do
      context '同一人物であるとき' do
        it 'trueが返ること' do
          expect(user.same?(user)).to be_truthy
        end
      end

      context '他人のとき' do
        it 'falseが返ること' do
          expect(other_user.same?(user)).to be_falsey
        end
      end
    end

    describe 'deleted_user?のテスト' do
      context 'userの論理削除がされていないとき' do
        it 'falseが返ること' do
          expect(user.deleted_user?).to be_falsey
        end
      end

      context 'userの論理削除がされているとき' do
        it 'trueが返ること' do
          user.is_deleted = true
          expect(user.deleted_user?).to be_truthy
        end
      end

      context '一度論理削除してからis_deletedをfalseに戻したとき' do
        it 'falseが返ること' do
          user.is_deleted = true
          user.is_deleted = false
          expect(user.deleted_user?).to be_falsey
        end
      end
    end

    describe 'change_name_when_deletedのテスト' do
      context 'userの論理削除がされているとき' do
        it 'nameに(退会済み)と加えられること' do
          user.is_deleted = true
          expect do
            user.change_name_when_deleted
          end.to change { user.name }.to include('(退会済み)')
        end
      end

      context 'userの論理削除がtrueからfalseになったとき' do
        it 'nameから(退会済み)が消されること' do
          user.is_deleted = true
          expect  do
            user.change_name_when_deleted
          end.to change { user.name }.to include('(退会済み)')
          user.is_deleted = false
          user.change_name_when_deleted
          expect(user.name).not_to include('(退会済み)')
        end
      end
    end
  end
end
