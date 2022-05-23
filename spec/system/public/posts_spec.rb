require 'rails_helper'

RSpec.describe '投稿に関するテスト', type: :system do
  let(:other_user) { create(:user, :other_user) }
  let(:post) { create(:post) }
  describe '新規投稿' do
    context 'ログインをしているとき' do
      before { login(other_user) }
      context '新規投稿が成功するとき' do
        it '新規投稿画面に遷移できること' do
          visit new_post_path
          expect(current_path).to eq new_post_path
        end
        it '正しい値が入っていること' do
          
        end
        it 'trail_placeがないとき' do
          
        end
      end
      context '新規投稿が失敗するとき' do
        it 'trail_placeがないとき' do
          
        end
        it 'bodyがないとき' do
          
        end
      end
    end
    context 'ログインをしていないとき' do
      it '新規投稿画面に遷移が出来ないこと' do
        
      end
    end
  end
    
  describe '投稿の編集' do
    
  end
  
end