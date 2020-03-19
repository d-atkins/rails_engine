require 'rails_helper'

describe 'Merchants API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends the info of a deleted merchant' do
    expect(Merchant.count).to eq(3)
    expect(Merchant.last.name).to eq('Ghost Shop')

    delete '/api/v1/merchants/3'

    deleted_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(deleted_merchant['data']['id']).to eq('3')
    expect(deleted_merchant['data']['attributes']['name']).to eq('Ghost Shop')
    expect(Merchant.last.name).to_not eq('Ghost Shop')
    expect(Merchant.count).to eq(2)
    expect{Merchant.find(3)}.to raise_error(ActiveRecord::RecordNotFound)
  end

end
