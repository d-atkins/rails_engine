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

    it 'most_items_sold' do
      expected = [Merchant.second, Merchant.first, Merchant.third]
      expect(Merchant.most_items_sold(3)).to eq(expected)
      expect(Merchant.most_items_sold(2)).to eq([expected[0], expected[1]])
      expect(Merchant.most_items_sold(1)).to eq([expected[0]])
    end

    it 'partial_matchables' do
      expect(Merchant.partial_matchables).to eq(['name'])
    end

    it 'search' do
      search_params = {'name' => 'Schroeder-Jerde', 'id' => '1'}

      expect(Merchant.search(search_params)).to eq([Merchant.first])
    end

    it 'partial_search' do
      search_params = {'name' => 'ghos'}

      expect(Merchant.search(search_params)).to eq([Merchant.third])
    end

    it 'revenue_across' do
      expected = 102058.34
      expect(Merchant.revenue_across('2012-03-20', '2012-03-30').round(2)).to eq(expected)
    end
  end
end
