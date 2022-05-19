require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'バリデーションのテスト' do
    before(:each) do
      @user = create(:user)
    end
      
    it '有効な値であれば保存される' do
      expect(@user).to be_valid
    end
    
    describe "nameカラム" do
      it 'ないと無効になる' do
        @user.name = ""
        expect(@user).to be_invalid
      end
      it '15文字以下であること' do
        @user.name = "a" * 16
        expect(@user).to be_invalid
      end
    end
  end
  
end
