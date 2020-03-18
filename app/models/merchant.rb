class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items
  has_many :transactions, through: :invoices

  def self.most_revenue(amount)
    joins(:transactions, :invoice_items)
      .where(transactions: {result: 1})
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group(:id)
      .order('revenue DESC')
      .limit(amount.to_i.abs)
  end
end
