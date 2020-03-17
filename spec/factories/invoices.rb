FactoryBot.define do
  factory :invoice do
    status { 0 }
    customer { nil }
    merchant { nil }
  end
end
