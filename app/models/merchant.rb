require './lib/modules/searchable'

class Merchant < ApplicationRecord
  include Searchable

  validates_presence_of :name
  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(amount)
    joins(:transactions, :invoice_items)
      .where(transactions: {result: 1})
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group(:id)
      .order('revenue DESC')
      .limit(amount.to_i.abs)
  end

  def self.most_items_sold(amount)
    joins(:transactions, :invoice_items)
      .where(transactions: {result: 1})
      .select('merchants.*, SUM(invoice_items.quantity) AS amount_sold')
      .group(:id)
      .order('amount_sold DESC')
      .limit(amount.to_i.abs)
  end

  def self.partial_matchables
    ['name']
  end

  def self.revenue_across(start_date, end_date)
    joins(:transactions, :invoice_items)
      .where(transactions: {result: 1}, invoices: {created_at: start_date..end_date})
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
