FactoryBot.define do
  factory(:user) do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '123456' }
  end

  factory(:message) do
    association :from
    association :to
    body { Faker::Lorem.sentence }
  end
end