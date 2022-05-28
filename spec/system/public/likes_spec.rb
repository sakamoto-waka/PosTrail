require 'rails_helper'

RSpec.describe 'いいね機能に関するテスト', type: :system do
  let!(:other_user) { create(:user, :other_user) }
  let!(:post) { create(:post) }

  context 'ユーザーがログインをしているとき' do
    it '他人の投稿にいいねができること' do
      login(other_user)
      # 投稿一覧にいく
      visit posts_path
      # postがあることを確認
      expect(page).to have_content(post.body)
      # いいねボタンを探してクリック
      find("#like_button_#{post.id}").click
      # postのいいねが1になる
      # visit post_path(post)
      # expect(post.likes.count).to eq(1)
    end
  end
end
