FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "4654405418249632" }
    credit_card_expiration_date { nil }
    result { 1 }
  end
end
