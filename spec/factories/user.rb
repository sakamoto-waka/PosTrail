FactoryBot.define do
  factory :user do
    name { "たろう" }
    email { "tarou@tarou.com" }
    introduction { 'これはテストです' }
    password { "password" }
    encrypted_password { "password" }
    
    trait :other_user do
      name { "はなこ" }
      email { "hanako@hanako.com" }
      introduction { 'これはテストです' }
      password { "password" }
      encrypted_password { "password" }
    end
  end
end