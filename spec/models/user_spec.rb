require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'モデルに関するテスト' do
    let(:user) { create(:user) }
    let(:other_user) { build(:user, :other_user) }
    it 'name, email, password, encrypted_passwordがあれば有効なこと' do
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
    # it 'passwordが暗号化されてること' do
    #   expect(@user.password_digest).to_not eq @user.password
    # end
    it 'introductionが201文字であれば無効になること' do
      user.introduction = 'あ' * 201
      expect(user).to be_invalid
    end
  end
  describe 'メソッドに関するテスト' do
  #   it 'userのis_deleted == falseならactive_for_authentication?メソッドはtrueが返ってくること' do
  #     expect(@user.active_for_authentication?).to eq true
  #   end
    # ↓↓↓↓↓異常系はテストが通ってしまう→書き方など合っていないと思われる↓↓↓↓↓
    context 'たろうでlooks(検索)した場合' do
      # it '@userを返すこと' do
      #   expect(User.looks('たろう')).to be_empty
      # end
      # it '@other_userは返さないこと' do
      #   expect(User.looks('たろう')).to_not include(@other_user)
      # end
    # context 'じろうでlooks検索した場合' do
    #   it 'じろうでlooks(検索)するとからを返すこと' do
    #     expect(User.looks('じろう')).to be_empty
    #   end
    end
  
  end


end
