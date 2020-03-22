require './lib/modules/searchable'

class Item < ApplicationRecord
  include Searchable

  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy

  before_create do
    self.unit_price /= 100.0 unless self.unit_price.class == Float
  end

  before_update do
    self.unit_price /= 100.0 unless self.unit_price.class == Float
  end

  def self.partial_matchables
    ['name', 'description']
  end
end
