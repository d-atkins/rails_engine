require 'rails_helper'

describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'methods' do
    before(:each) do
      importer = Importer.new
      importer.reset_all_tables('./spec/fixtures/truncated/')
    end

    it 'most_revenue' do
      expected = [Merchant.second, Merchant.first, Merchant.third]
      expect(Merchant.most_revenue(3)).to eq(expected)
      expect(Merchant.most_revenue(2)).to eq([expected[0], expected[1]])
      expect(Merchant.most_revenue(1)).to eq([expected[0]])
    end
  end
end
