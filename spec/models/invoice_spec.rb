require 'rails_helper'

describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values([:shipped]) }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
  end

  describe 'methods' do
    before(:each) do
      importer = Importer.new
      importer.reset_all_tables('./spec/fixtures/truncated/')
    end

    it 'revenue' do
      expect(Invoice.revenue('2012-03-22', '2012-03-24').round(2)).to eq(1539.79)
      expect(Invoice.revenue('2012-03-18', '2012-03-20').round(2)).to eq(123.45)
      expect(Invoice.revenue('2012-03-20', '2012-03-30').round(2)).to eq(22959.47)
    end
  end
end
