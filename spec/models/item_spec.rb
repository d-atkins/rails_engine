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

  describe 'callbacks' do
    it 'convert price upon creation' do
      item = create(:item, unit_price: 552)
      expect(item.unit_price).to eq(5.52)
    end

    it 'convert price upon updating' do
      item = create(:item, unit_price: 552)
      item.update(unit_price: 123)
      expect(item.unit_price).to eq(1.23)
    end
  end
end
