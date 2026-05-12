FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    completed { false }
    user { nil }
  end
end
