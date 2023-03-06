FactoryBot.define do
  factory :item do
    title { 'test' }
    explanation { 'test' }
    price { 300 }
    category_id { 2 }
    condition_id { 2 }
    delivery_charge_id { 2 }
    prefecture_id { 2 }
    delivery_day_id { 2 }
    association :user

    after(:build) do |item|
      item.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
      item.images.attach(io: File.open('public/images/test_image2.png'), filename: 'test_image2.png')
      item.images.attach(io: File.open('public/images/test_image3.png'), filename: 'test_image3.png')
      item.images.attach(io: File.open('public/images/test_image4.png'), filename: 'test_image4.png')
      item.images.attach(io: File.open('public/images/test_image5.png'), filename: 'test_image5.png')
    end
  end
end
