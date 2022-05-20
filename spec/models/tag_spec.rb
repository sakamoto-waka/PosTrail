require 'rails_helper'

RSpec.describe Tag, type: :model do
  
  describe 'モデルに関するテスト' do
    before do
      @tag = Tag.create(name: 'テスト用タグ')
    end
    it 'nameがあれば有効であること' do 
      expect(@tag).to be_valid
    end
    it 'nameがなければ無効であること' do
      @tag.name = ''
      expect(@tag).to be_invalid
    end
    it 'nameが同じであれば無効であること' do
      tag2 = Tag.new(name: @tag.name)
      expect(tag2).to be_invalid
    end
  end
  
end
