require 'rails_helper'

describe 'Merchants API:' do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends one merchant by id' do
    get '/api/v1/merchants/3'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data'].length).to eq(1)
    expect(merchant['data'].first['id']).to eq('3')
  end

end
