require 'rails_helper'

RSpec.describe 'ユーザーモデル', type: :model do

  describe 'モデルに関するテスト' do
    let(:user) { create(:user) }
    let(:other_user) { build(:user, :other_user) }
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
    let(:user) { create(:user) }
    let(:other_user) { build(:user, :other_user) }
    it 'userのis_deleted == falseならactive_for_authentication?メソッドはtrueが返ってくること' do
      expect(user.active_for_authentication?).to eq true
    end
    context 'たろうでlooks(検索)した場合' do
      it '@userを返すこと' do
        expect(User.looks('たろう')).to be_empty
      end
      it '@other_userは返さないこと' do
        expect(User.looks('たろう')).to_not include(other_user)
      end
    end
    context 'じろうでlooks検索した場合' do
      it 'じろうでlooks(検索)すると空を返すこと' do
        expect(User.looks('じろう')).to be_empty
      end
    end

  end


end
