require 'rails_helper'

RSpec.describe '投稿に関するテスト', type: :system do
  describe '新規投稿' do
    let(:other_user) { create(:user, :other_user) }
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
    context 'ログインしているとき'
      context '編集が成功するとき'
        it '編集画面に遷移できること'
        it 'prefecture_idとbodyが入っていること'
        it '編集した内容が存在していること'
      context '新規投稿が失敗するとき'
        it 'prefecture_idがないとき'
        it 'bodyがないとき'
  end
  
end