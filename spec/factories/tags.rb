FactoryBot.define do
  factory :tag do
    label { Faker::Lorem.word }
    item_id nil
  end
end