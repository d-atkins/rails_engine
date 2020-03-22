class Invoice < ApplicationRecord
  validates_presence_of :status
  enum status: %w(shipped)
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def self.revenue(start_date, end_date)
    end_date += ' 23:59:59.999999' if end_date.length <= 11
    joins(:invoice_items, :transactions)
      .where(transactions: {result: 1}, created_at: start_date..end_date)
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
