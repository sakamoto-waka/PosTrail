FactoryBot.define do
  factory :comment do
    comment { 'テスト用コメント' }
    user
    post
  end
end
