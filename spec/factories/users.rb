FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name { '片桐' }
    first_name { '大樹' }
    last_name_kana { 'カタギリ' }
    first_name_kana { 'ダイキ' }
    birthday { '1930-01-31' }
  end
end
