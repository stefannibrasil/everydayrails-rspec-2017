FactoryBot.define do
  factory :user, class: 'User', aliases: [:owner] do
    first_name 'Stefanni'
    last_name 'Brasil'
    sequence(:email) { |n| "stefanni#{n}@example.com" }
    password 'bobdatacats'
  end
end
