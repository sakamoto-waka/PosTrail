require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { Tag.create(name: 'テスト用タグ') }
  describe 'モデルに関するテスト' do
    describe 'バリデーションに関するテスト' do
      it 'nameがあれば有効であること' do
        expect(tag).to be_valid
      end
      it 'nameがなければ無効であること' do
        tag.name = ''
        expect(tag).to be_invalid
      end
      it 'nameが同じであれば無効であること' do
        tag2 = Tag.new(name: tag.name)
        expect(tag2).to be_invalid
      end
    end
    describe 'メソッドに関するテスト' do
      # describe 'self.looks(content)のテスト' do
      #   context '「テスト用タグ」でlooksしたとき' do
      #     it 'tag.postsを返すこと' do
      #       expect(Tag.looks('テスト用タグ')).to include(tag.posts)
      #     end
      #   end
      # end
    end
  end
end
