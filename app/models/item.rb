require './lib/modules/searchable'

class Item < ApplicationRecord
  include Searchable

  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy

  def self.partial_matchables
    ['name', 'description']
  end
end
