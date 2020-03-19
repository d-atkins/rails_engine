require 'rails_helper'

describe 'Merchants API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends one merchant by id' do
    get '/api/v1/merchants/3'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq('3')
    expect(merchant['data']['attributes']['name']).to eq('Ghost Shop')
  end

end
