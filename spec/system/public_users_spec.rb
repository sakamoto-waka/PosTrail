require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  let(:user) { build(:user) }
  let(:post) { build(:post, user_id: user.id) }
  describe 'ユーザー新規登録ができること' do
    it '正しい情報を入力すればユーザー新規登録が出来てuser_pathに移動する' do
      # トップページに移動
      visit root_path
      # トップページにサインアップへ遷移する新規登録ボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.encrypted_password
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        click_button('新規登録')
      }.to change { User.count }.by(1)
      # user_pathへ遷移する
      expect(page).to have_current_path user_path(1)
      # マイページの表示がある
      expect(page).to have_content('マイページ')
      # ログアウトボタンが表示されている事を確認
      expect(page).to have_content('ログアウト')
      # 新規登録ボタンやログインボタンが無いことを確認する
      expect(page).to_not have_content('ログイン')
      expect(page).to_not have_content('新規登録')
    end
  end
  describe 'ユーザーログインできること' do
    let!(:user) { create(:user, :other_user) }
    let!(:post) { create(:post, user_id: user.id) }
    it 'ログイン後投稿一覧に移動すること' do
      sign_in user
      visit user_path(user)
      # ユーザーの投稿のみが表示されている
      expect(page).to have_content(post.body)

    end
  end

end
