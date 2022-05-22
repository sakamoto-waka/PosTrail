require 'rails_helper'

RSpec.describe 'いいね機能に関するテスト', type: :system do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  context 'ユーザーがログインをしているとき' do
    it '他人の投稿にいいねができること' do
      login(user)
      # 投稿一覧にいく
      visit posts_path
      # postがあることを確認
      expect(page).to have_content('')
      # いいねボタンを探してクリック
      # postのいいねが1になる
      
      
    end
  end
  
end

