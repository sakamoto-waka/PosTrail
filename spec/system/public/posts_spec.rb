require 'rails_helper'

RSpec.describe '投稿に関するテスト', type: :system do
  let(:other_user) { create(:user, :other_user) }
  describe '新規投稿' do
    let(:post) { build(:post) }
    context 'ログインをしているとき' do
      before { login(other_user) }
      context '新規投稿が成功するとき' do
        it '新規投稿画面に遷移できること' do
          visit new_post_path
          expect(current_path).to eq new_post_path
        end
        it 'prefecture_idとbodyが入っていること' do
          visit new_post_path
          find("option[value='1']").select_option
          fill_in 'post_body', with: post.body
          expect{
            find('button[name="button"]').click
          }.to change { Post.count }.by(1)
        end
        it '投稿した内容が存在していること' do
          visit new_post_path
          find("option[value='1']").select_option
          fill_in 'post_body', with: '新規投稿してます'
          find('button[name="button"]').click
          expect(current_path).to eq posts_path
          expect(page).to have_selector '#flash-message', text: '投稿しました'
          expect(page).to have_content('新規投稿してます')
        end
      end
      context '新規投稿が失敗するとき' do
        it 'prefecture_idがないとき' do
          visit new_post_path
          fill_in 'post_body', with: post.body
          expect{
            find('button[name="button"]').click
          }.to change { Post.count }.by(0)
        end
        it 'bodyがないとき' do
          visit new_post_path
          find("option[value='1']").select_option
          expect{
            find('button[name="button"]').click
          }.to change { Post.count }.by(0)
        end
      end
    end
    context 'ログインをしていないとき' do
      it '新規投稿画面に遷移が出来ないこと' do
        visit new_post_path
        expect(current_path).to_not eq new_post_path
      end
      it 'ログイン画面に遷移すること' do
        visit new_post_path
        expect(current_path).to eq new_user_session_path
      end
    end
  end
    
  describe '投稿の編集' do
    let(:user) { create(:user, :other_user) }
    let(:other_user) { create(:user, :like_user) }
    let(:post) { create(:post, user: user) }
    let(:other_post) { create(:post, user: other_user) }
    context 'ログインしているとき' do
      before { login(user) }
      context '編集が成功するとき' do
        it '編集画面に遷移できること' do
          visit edit_post_path(post)
          expect(current_path).to eq edit_post_path(post)
        end
        it 'prefecture_idとbodyが入っていること' do
          visit edit_post_path(post)
          find("option[value='1']").select_option
          fill_in 'post_body', with: post.body
          expect{
            find('button[name="button"]').click
          }.to change { Post.count }.by(0)
        end
        it '編集した内容が存在していること' do
          visit edit_post_path(post)
          find("option[value='1']").select_option
          fill_in 'post_body', with: '編集しました'
          find('button[name="button"]').click
          expect(current_path).to eq post_path(post)
          expect(page).to have_selector '#flash-message', text: '投稿内容を更新しました'
          expect(page).to have_content('編集しました')
        end
      end
      # context '編集が失敗するとき' do
      #   it 'prefecture_idがないとき' do
      #     visit edit_post_path(post)
      #     post.prefecture_id = nil
      #     fill_in 'post_body', with: post.body
      #     find('button[name="button"]').click
      #     expect(post.errors.messages[:prefecture_id][1]).to eq('入力してください')
      #   end
      #   it 'bodyがないとき' do
      #     visit edit_post_path(post)
      #     find("option[value='1']").select_option
      #     fill_in 'post_body', with: ''
      #     find('button[name="button"]').click
      #     expect(post.errors.messages[:body][0]).to eq('入力してください')
      #   end
      # end
      context '他人の投稿を編集しようとしたとき' do
        it '投稿詳細にリダイレクトされる' do
          visit edit_post_path(other_post)
          expect(current_path).to eq post_path(other_post)
        end
      end
    end
    context 'ログインをしていないとき' do
      it '編集画面に遷移が出来ないこと' do
        visit "/posts/#{post.id}/edit"
        expect(current_path).to_not eq edit_post_path(post)
      end
      it 'ログイン画面に遷移すること' do
        visit "/posts/#{post.id}/edit"
        expect(current_path).to eq new_user_session_path
      end
    end
    
  end
  
end