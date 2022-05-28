FactoryBot.define do
  factory :post  do
    prefecture_id { 1 }
    body { 'テストの投稿です' }
    user
    
    # after(:create) do |post|
    #   create_list(:post_tag, 1, post: post, tag: create(:tag))
    # end
  end
end