require 'rails_helper'

describe 'Merchants API:' do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends back info of newly created merchant' do
    post '/api/v1/merchants', params: {merchant: {name: 'Test Store'}}

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq('4')
    expect(merchant['data']['type']).to eq('merchant')
    expect(merchant['data']['attributes']['name']).to eq('Test Store')
  end

end
