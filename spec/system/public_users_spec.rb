require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  let(:user) { build(:user) }
  let(:other_user) { create(:user, :other_user) }
  let(:post) { build(:post, user_id: user.id) }
  describe 'ログイン前' do
    describe '新規登録' do
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
      it 'メールアドレスがないと新規登録に失敗すること' do
        visit root_path
        expect(page).to have_content('新規登録')
        visit new_user_registration_path
        fill_in 'user_name', with: user.name
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.encrypted_password
        click_button '新規登録'
        expect(current_path).to eq users_path
        expect(page).to have_content 'メールアドレスが入力されていません'
      end
      it '登録済みのメールアドレスを入れると新規登録に失敗すること' do
        visit root_path
        expect(page).to have_content('新規登録')
        visit new_user_registration_path
        fill_in 'user_name', with: user.name
        fill_in 'user_email', with: other_user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.encrypted_password
        click_button '新規登録'
        expect(current_path).to eq users_path
        expect(page).to have_content 'メールアドレスは既に使用されています'
      end
    end
    describe 'ユーザーはログインできること' do
      let!(:other_user) { create(:user, :other_user) }
      let!(:post) { create(:post, user_id: other_user.id) }
      it '正しい情報を入力しるとログインが出来て投稿一覧に移動すること' do
        sign_in other_user
        visit posts_path
        expect(current_path).to eq posts_path
        # ユーザーの投稿が表示されている
        expect(page).to have_content(post.body)
      end
      it 'メールアドレスが間違っていればログインが出来ないこと' do
        # visit new_user_session_path
        # fill_in 'user_email', with: other_user.email
        # fill_in 'user_password', with: other_user.password
        # click_button 'submit'
      end
      it 'パスワードが空であればログインが出来ないこと' do
      end
    end
  end

  describe 'ログイン後' do
  end
end
