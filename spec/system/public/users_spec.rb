require 'rails_helper'

RSpec.describe 'ユーザーに関するテスト', type: :system do
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
          expect  do
            click_button('新規登録')
          end.to change { User.count }.by(1)
          # user_pathへ遷移する
          user_me = User.find_by!(email: user.email)
          expect(page).to have_current_path user_path(user_me)
          # マイページの表示がある
          expect(page).to have_text('マイページ')
          # ログアウトボタンが表示されている事を確認
          expect(page).to have_content('ログアウト')
          # 新規登録ボタンやログインボタンが無いことを確認する
          expect(page).not_to have_link('ログイン', href: '/users/sign_in')
          expect(page).not_to have_content('新規登録')
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
    end
  end

  describe 'ログイン後' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user_id: other_user.id) }

    describe 'ユーザーログインのテスト' do
      context '入力値が正常なとき' do
        it 'ログインが出来て投稿一覧に移動すること' do
          visit new_user_session_path
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'password'
          click_button 'ログイン'
          expect(current_path).to eq posts_path
          expect(page).to have_content(post.body)
        end
      end

      context 'メールアドレスが間違っているとき' do
        it 'ログインが出来ないこと' do
          visit new_user_session_path
          fill_in 'user_email', with: 'incorrect_email@email.com'
          fill_in 'user_password', with: user.password
          click_button 'ログイン'
          expect(page).to have_content('メールアドレスまたはパスワードが違います。')
        end
      end

      context 'パスワードが空であるとき' do
        it 'ログインが出来ないこと' do
          visit new_user_session_path
          fill_in 'user_email', with: user.email
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
          visit edit_user_path(user)
          expect(current_path).to eq edit_user_path(user)
        end
        it '他人の編集ページには遷移できないこと' do
          visit edit_user_path(other_user)
          expect(current_path).to eq user_path(other_user)
        end
      end

      context 'フォームの入力値が正常なとき' do
        it 'ユーザーの編集が成功すること' do
          visit edit_user_path(user)
          fill_in 'user_name', with: user.name
          click_button '更新する'
          expect(current_path).to eq user_path(user)
          expect(page).to have_selector '#flash-message', text: 'ユーザー情報を更新しました'
        end
        it 'マイページの紹介文が変更されていること' do
          visit edit_user_path(user)
          fill_in 'user_name', with: user.name
          fill_in 'user_introduction', with: 'aaa'
          click_button '更新する'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content('aaa')
        end
      end

      describe 'account_image更新のテスト' do
        it 'account_imageが正しく更新されること' do
          visit edit_user_path(user)
          user_old_account_image = nil
          attach_file 'user[account_image]', "#{Rails.root}/spec/fixtures/images/test1.png"
          click_button '更新する'
          expect(user.account_image).not_to eq user_old_account_image
        end
      end

      context 'ユーザーネームが空のとき' do
        it 'ユーザーの編集が失敗すること' do
          visit edit_user_path(user)
          fill_in 'user_name', with: ''
          fill_in 'user_introduction', with: 'aaa' * 20
          click_button '更新する'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'ユーザー名は2文字以上で入力してください'
        end
      end
    end

    describe 'ユーザーの名前' do
      context 'is_deleted == trueのとき' do
        let(:deleted_user) { create(:user, name: 'いないはず', is_deleted: true) }

        it 'ユーザー一覧に削除済みユーザーが表示されないこと' do
          visit users_path
          expect(page).not_to have_content(deleted_user.name)
        end
      end
    end
  end
end
