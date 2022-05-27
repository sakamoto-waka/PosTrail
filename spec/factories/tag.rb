FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "#{n}" }
    
    trait :tag_with_name do
      name { '名前付きタグ' }
    end
  end
end