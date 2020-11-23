FactoryBot.define do
  factory :participant do
    nickname { "test" }
    email { "test@example.com" }
    telephone_number { "09098761234" }
    password { "testparticipant" }
    agreement { true }
  end
end