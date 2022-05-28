require 'rails_helper'

RSpec.describe 'admin側のユーザーに関するテスト', type: :system do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  describe 'ログイン前' do
    context 'admin_root_pathへいこうとしたとき' do
      it 'adminサインインページへ飛ばされること' do
        visit admin_root_path
        expect(current_path).to eq new_admin_session_path
      end
    end
  end

  describe 'ログイン後' do
    before { admin_login(admin) }

    it 'ログインできること' do
      visit admin_root_path
      expect(current_path).to eq admin_root_path
    end
    describe 'ユーザーの編集' do
      before do
        visit edit_admin_user_path(user)
        expect(current_path).to eq edit_admin_user_path(user)
        choose 'user_is_deleted_true'
        find('button[name="button"]').click
      end

      context '会員ステータスを退会にしたとき' do
        it 'name（退会済みユーザー）に変更されること' do
          expect(current_path).to eq admin_user_path(user)
          expect(page).to have_text("#{user.name}(退会済み)")
        end
      end

      context 'is_deleted == trueのとき' do
        it 'ユーザー一覧に退会の文字があること' do
          visit admin_root_path
          expect(page).to have_text('退会')
        end
      end
    end
  end
end
