FactoryBot.define do
  factory :user do
    name { "たろう" }
    email { "tarou@tarou.com" }
    password { "password" }
    encrypted_password { "password" }
  end
  factory :other_user do
    name { "はなこ" }
    password { "password" }
    encrypted_password { "password" }
    email { "hanako@hanako.com" }
  end
end