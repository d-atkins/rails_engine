require 'rails_helper'

describe 'Merchants API:' do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends a list of all merchants' do
    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants['data'].length).to eq(3)
    expect(merchants['data'].first['id']).to eq('1')
    expect(merchants['data'].second['id']).to eq('2')
    expect(merchants['data'].third['id']).to eq('3')
  end

end
