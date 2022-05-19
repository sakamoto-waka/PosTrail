FactoryBot.define do
  factory :user do
    name { "aaaa" }
    email { "aaaa@aaaa.com" }
    password { "password" }
    encrypted_password { "password" }
  end
end