FactoryBot.define do
  factory :item do
    product                   {'test'}
    description               {Faker::Lorem.sentence}
    category_id               { 2 }
    state_id                  { 2 }
    delivery_charge_burden_id { 2 }
    delivery_area_id          { 2 }
    delivery_day_id           { 2 }
    price                     { '1000' }
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/panda.jpeg'), filename: 'panda.jpeg')
    end
  end
end
