FactoryBot.define do
  factory :purchase_delivery do
    token            { 'tok_abcdefghijk00000000000000000' }
    postcode         { '123-4567' }
    delivery_area_id { Random.rand(2..48) }
    city             { '中野区' }
    block            { '南台1-1' }
    phone_number     { '08011112222' }
  end
end
