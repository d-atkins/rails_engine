class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :merchant_id

  attribute :merchant_name do |object|
    object.merchant.name
  end

  belongs_to :merchant
end
