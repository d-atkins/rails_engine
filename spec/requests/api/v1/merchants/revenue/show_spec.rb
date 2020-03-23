require 'rails_helper'

describe 'Merchants API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends the revenue of a merchant' do
    get '/api/v1/merchants/3/revenue'

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue['data']['id']).to eq(nil)
    expect(revenue['data']['attributes']['revenue']).to eq(123.45)
  end

end
