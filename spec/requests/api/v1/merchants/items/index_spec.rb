require 'rails_helper'

describe 'Merchants API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends a list of all items from a merchant' do
    get '/api/v1/merchants/2/items'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants['data'].length).to eq(6)
    expect(merchants['data'].first['id']).to eq('10')
    expect(merchants['data'].first['type']).to eq('item')
    expect(merchants['data'].second['id']).to eq('11')
    expect(merchants['data'].last['id']).to eq('15')
  end

end
