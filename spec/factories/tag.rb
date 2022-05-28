FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "#{n}" }
  end
end