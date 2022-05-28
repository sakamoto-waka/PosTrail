require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'モデルに関するテスト' do
    before do
      @comment = build(:comment)
    end

    it 'commentが2文字であれば有効であること' do
      expect(@comment).to be_valid
    end
    it 'commentがなければ無効であること' do
      @comment.comment = ''
      expect(@comment).to be_invalid
    end
    it 'commentが101文字であれば無効であること' do
      @comment.comment = 'a' * 101
      expect(@comment).to be_invalid
    end
  end
end
