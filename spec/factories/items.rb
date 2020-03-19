FactoryBot.define do
  factory :item do
    name { "A Worldly Possession" }
    description { "You don't need to need one to buy one" }
    unit_price { 10.59 }
    association :merchant
  end
end
