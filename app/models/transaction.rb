class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  validates_presence_of :result
  enum result: %w(failed success)
  belongs_to :invoice
end
