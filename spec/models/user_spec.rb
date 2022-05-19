require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "User" do
    it "有効な値であれば保存される" do
      expect(FactoryBot.build(:user)).to be_valid
    end
    
    it "nameとemailを持っている"
      
    it "nameがないと無効になる"
  end
  
end
