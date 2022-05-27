FactoryBot.define do
  factory :user do
    name { "たろう" }
    sequence(:email) { |n| "tarou#{n}@tarou.com" }
    introduction { 'これはテストです' }
    password { "password" }
    
    trait :other_user do
      name { "はなこ" }
      email { "hanako@hanako.com" }
      introduction { 'これはテストです' }
      password { "password" }
    end
    
    trait :like_user do
      name { "aaaa" } 
      email { "aaaa@aaaa.com" }
      password { "password" }
    end
    
  end
end