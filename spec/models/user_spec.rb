require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "モデル" do
    before(:each) do
      @user = create(:user)
    end
      
    it "有効な値であれば保存される" do
      expect(@user).to be_valid
    end
    
    it "nameとemailを持っている" 
      
    it "nameがないと無効になる" do
      user = FactoryBot.build(:user, name: nil)
      expect(user).to be_invalid
    end
  end
  
end
