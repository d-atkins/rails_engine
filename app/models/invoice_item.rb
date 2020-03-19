class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price
  belongs_to :item
  belongs_to :invoice

  before_create do
    self.unit_price /= 100.0
  end

  # before_update do
  #   self.unit_price /= 100.0
  # end
end
