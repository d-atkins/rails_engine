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
end
