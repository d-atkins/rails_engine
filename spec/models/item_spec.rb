require 'rails_helper'

describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should belong_to :merchant }
  end

  describe 'methods' do
    before(:each) do
      importer = Importer.new
      importer.reset_all_tables('./spec/fixtures/truncated/')
    end

    it 'partial_matchables' do
      expect(Item.partial_matchables).to eq(['name', 'description'])
    end

    it 'search' do
      search_params = {'unit_price' => '751.07', 'merchant_id' => '1'}

      expect(Item.search(search_params)).to eq([Item.first])

      expected = [3, 5, 7, 8, 12]
      search_params = {'name' => 'Item E'}

      expect(Item.search(search_params).pluck(:id)).to eq(expected)
    end

    it 'partial_search' do
      search_params = {'name' => 'tem mi'}

      expect(Item.search(search_params)).to eq([Item.second])

      search_params = {'description' => 'lupTATe Aut Lab'}

      expect(Item.search(search_params)).to eq([Item.fifth])
    end
  end
end
