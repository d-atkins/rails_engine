require 'rails_helper'

describe 'Items API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends the merchant of an item' do
    get '/api/v1/items/16/merchant'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq('3')
    expect(merchant['data']['attributes']['name']).to eq('Ghost Shop')
  end

end
