FactoryBot.define do
  factory :user do
    nickname {'test'}
    email {'test@test'}
    password {'test11'}
    password_confirmation {password}
    last_name {'テスト'}
    last_name_kana {'テスト'}
    first_name {'テスト'}
    first_name_kana {'テスト'}
    birthday {'1930-01-01'}
  end
end