require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'バリデーションのテスト' do
    before(:each) do
      @user = create(:user)
    end
      
    it 'name, email, password, encrypted_passwordがあれば有効なこと' do
      expect(@user).to be_valid
    end
    
    describe "nameカラム" do
      it 'nameがないと無効になる' do
        @user.name = ""
        expect(@user).to be_invalid
      end
      it 'nameは15文字以下であること' do
        @user.name = "a" * 16
        expect(@user).to be_invalid
      end
      it "nameは2文字以上であること"
      
    end
  end
  
end
