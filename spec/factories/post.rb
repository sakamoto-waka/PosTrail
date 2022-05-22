FactoryBot.define do
  factory :post  do
    prefecture_id { 1 }
    body { 'テストの投稿です' }
    user
  end
end