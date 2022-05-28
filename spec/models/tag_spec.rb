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
    # describe 'メソッドに関するテスト' do
    #   describe 'self.looks(content)のテスト' do
    #     context '「タグ1」でlooksしたとき' do
    #       let(:tag) { create(:tag) }
    #       it 'tag.postsを返すこと' do
    #         expect(Tag.looks('タグ1')).to include('タグ1')
    #       end
    #     end
    #   end
    # end
  end
end
