require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'モデルに関するテスト' do
    before do
      @user = build(:user)
      @other_user = build(:user, :other_user)
    end

    it 'name, email, password, encrypted_passwordがあれば有効なこと' do
      expect(@user).to be_valid
    end
    it 'nameがないと無効になること' do
      @user.name = nil
      expect(@user).to be_invalid
    end
    it 'nameは15文字以下は無効になること' do
      @user.name = 't' * 16
      expect(@user).to be_invalid
    end
    it 'nameは2文字以下は無効になること' do
      @user.name = 't'
      expect(@user).to be_invalid
    end
    it 'emailがなければ無効になること' do
      @user.email = nil
      expect(@user).to be_invalid
    end
    # it 'emailが重複してたら無効' do
    #   @other_user.email = @user.email
    #   expect(@other_user).to be_invalid
    # end
    it 'passwordがなければ無効になること' do
      @user.password = nil
      expect(@user).to be_invalid
    end
    # it 'passwordが暗号化されてること' do
    #   expect(@user.password_digest).to_not eq @user.password
    # end
    it 'introductionが201文字であれば無効になること' do
      @user.introduction = 'あ' * 201
      expect(@user).to be_invalid
    end
  end
  describe 'メソッドに関するテスト' do
  #   it 'userのis_deleted == falseならactive_for_authentication?メソッドはtrueが返ってくること' do
  #     expect(@user.active_for_authentication?).to be_true
  #   end
    context 'たろうでlooksで検索した場合' do
      before do
        @user = build(:user)
      end
      # it '@userを返すこと' do
      #   expect(User.looks('たろう')).to include(@user)
      # end
    end
  
  end


end
