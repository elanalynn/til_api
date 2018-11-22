FactoryBot.define do
  factory :item do
    content { Faker::Lorem.sentences(2) }
    date { Faker::Date.between(1.year.ago, Date.today) }
  end
end
