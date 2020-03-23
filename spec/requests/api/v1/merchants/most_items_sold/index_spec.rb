require 'rails_helper'

describe 'Merchants API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends a list of merchants with the most items sold' do
    get '/api/v1/merchants/most_items?quantity=2'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants['data'].length).to eq(2)
    expect(merchants['data'].first['id']).to eq('2')
    expect(merchants['data'].second['id']).to eq('1')
  end

end
