require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'モデルに関するテスト' do
    let(:post) { build(:post) }
    it 'body, prefecture_idがあれば有効であること' do
      expect(post).to be_valid
    end
    it '画像が有効なこと' do
      post.trail_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/images/test1.png'))
      expect(post).to be_valid
    end
    it 'bodyがないと無効であること' do
      post.body = ''
      expect(post).to be_invalid
    end
    it 'prefecture_idがないと無効であること' do
      post.prefecture_id = nil
      expect(post).to be_invalid
    end
    it 'trail_placeが26文字であれば無効であること' do
      post.trail_place = 'a' * 26
      expect(post).to be_invalid
    end
    it 'bodyが201文字であれば無効であること' do
      post.body = 'a' * 201
      expect(post).to be_invalid
    end
  end
end
