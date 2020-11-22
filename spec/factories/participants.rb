FactoryBot.define do
  factory :participant do
    nickname { "test" }
    sequence(:email) { |n| "test#{n}@example.com" }
    telephone_number { "09098761234" }
    password { "testparticipant" }
    agreement { "true" }
  end
end