require 'rails_helper'

describe 'Merchants API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends the new info of an updated merchant' do
    patch '/api/v1/merchants/3', params: {merchant: {name: 'Superb Ghost Shop'}}

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq('3')
    expect(merchant['data']['attributes']['name']).to eq('Superb Ghost Shop')
    expect(Merchant.last.name).to eq('Superb Ghost Shop')
  end

end
