class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy

  before_create do
    self.unit_price /= 100.0
  end
end
