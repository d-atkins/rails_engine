FactoryBot.define do
  factory :invoice_item do
    quantity { 14 }
    unit_price { 1.59 }
    item { nil }
    invoice { nil }
  end
end
