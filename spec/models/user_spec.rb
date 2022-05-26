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
      expect(user.encrypted_password).to_not eq user.password
    end
    it 'introductionが201文字であれば無効になること' do
      user.introduction = 'あ' * 201
      expect(user).to be_invalid
    end
  end
  describe 'メソッドに関するテスト' do
    it 'userのis_deleted == falseならactive_for_authentication?メソッドはtrueが返ってくること' do
      expect(user.active_for_authentication?).to eq true
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
          expect(user.name).to_not eq('元の名前')
        end
      end
      context 'userのis_deleted == falseのとき' do
        before { user.is_deleted = false }
        it 'nameが退会済みユーザーに変わらないこと' do
          user.deleted_user_change_name
          expect(user.name).to_not eq('退会済みユーザー')
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
          expect(User.looks('たろう')).to be_empty
        end
        it 'other_userは返さないこと' do
          expect(User.looks('たろう')).to_not include(other_user)
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
            expect{
              user.follow(other_user.id)
            }.to change{ user.relationships.count }.by(1)
          end
          it 'other_userのrelationshipsは増えないこと' do
            expect{
              user.follow(other_user.id)
            }.to change{ other_user.relationships.count }.by(0)
          end
        end
      end
      describe 'unfollowのテスト' do
        context 'フォローを外すとき' do
          it 'userのrelationshipsが1減ること' do
            expect{
              user.follow(other_user.id)
            }.to change{ user.relationships.count }.by(1)
            expect{
              user.unfollow(other_user.id)
            }.to change{ user.relationships.count }.by(-1)  
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
  end
end