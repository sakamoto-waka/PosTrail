require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  let(:user) { build(:user) }
  let(:other_user) { create(:user, :other_user) }
  let(:post) { build(:post, user_id: user.id) }
  describe 'ログイン前' do
    describe '新規登録のテスト' do
      context '入力値が正常なとき' do
        it 'ユーザー新規登録が出来てuser_pathに移動する' do
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
          fill_in 'user_password_confirmation', with: user.password
          # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
          expect{
            click_button('新規登録')
          }.to change { User.count }.by(1)
          # user_pathへ遷移する
          user_me = User.find_by!(email: user.email)
          expect(page).to have_current_path user_path(user_me)
          # マイページの表示がある
          expect(page).to have_content('マイページ')
          # ログアウトボタンが表示されている事を確認
          expect(page).to have_content('ログアウト')
          # 新規登録ボタンやログインボタンが無いことを確認する
          expect(page).to_not have_content('ログイン')
          expect(page).to_not have_content('新規登録')
        end
      end
      context 'メールアドレスがないとき' do
        it '新規登録に失敗すること' do
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
      end
      context '登録済みのメールアドレスを入れるとき' do
        it '新規登録に失敗すること' do
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
      it 'どの編集画面にもいけないこと' do
        visit edit_user_path(other_user)
        expect(current_path).to eq user_path(other_user)
      end
    end
    describe 'ログイン後' do
      let!(:other_user) { create(:user, :other_user) }
      let!(:post) { create(:post, user_id: other_user.id) }
      describe 'ユーザーログインのテスト' do
        context '入力値が正常なとき' do
          it 'ログインが出来て投稿一覧に移動すること' do
            visit new_user_session_path
            fill_in 'user_email', with: other_user.email
            fill_in 'user_password', with: 'password'
            click_button('ログイン')
            expect(current_path).to eq posts_path
            expect(page).to have_content(post.body)
          end
        end
        context 'メールアドレスが間違っているとき' do
          it 'ログインが出来ないこと' do
            visit new_user_session_path
            fill_in 'user_email', with: 'incorrect_email@email.com'
            fill_in 'user_password', with: other_user.password
            click_button 'ログイン'
            expect(page).to have_content('メールアドレスまたはパスワードが違います。')
          end
        end
        context 'パスワードが空であるとき' do
          it 'ログインが出来ないこと' do
            visit new_user_session_path
            fill_in 'user_email', with: other_user.email
            fill_in 'user_password', with: 'incorrect_password'
            click_button 'ログイン'
            expect(page).to have_content('メールアドレスまたはパスワードが違います。')
          end
        end
      end
      describe 'ユーザー編集のテスト' do
        let!(:user) { create(:user) }
        let(:other_user) { create(:user, :other_user) }
        before { login(user) }
        describe '編集権限に関するテスト' do
          it '自分の編集ページへ遷移できること' do
            
          end
          it '他人の編集ページには遷移できないこと' do
          end
        end
        context 'フォームの入力値が正常なとき' do
          it 'ユーザーの編集が成功すること' do
          end
        end
        context 'メールアドレスが空のとき' do
          it 'ユーザーの編集が失敗すること' do
          end
        end
      end
    end
  end

  describe 'ログイン後' do
  end



end
