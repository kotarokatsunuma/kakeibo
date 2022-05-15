FactoryBot.define do
  factory :book do
   year         {'2022'}
   month        {'5'}
   inout        {'収入'}
   category     {'給料'}
   amount       {'30'}
   association :user
  end
end
