class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :revenue do |object|
    object.revenue
  end
end
