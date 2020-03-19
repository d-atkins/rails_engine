FactoryBot.define do
  factory :invoice_item do
    quantity { 14 }
    unit_price { 1.59 }
    association :item
    association :invoice
  end
end
