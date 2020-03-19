require 'rails_helper'

describe 'Items API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends back info of newly created item' do
    item_params = {name: 'thing', description: 'buy it', unit_price: 2.5}
    post '/api/v1/items', params: {item: item_params}

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data']['id']).to eq('17')
    expect(items['data']['type']).to eq('item')
    expect(items['data']['attributes']['name']).to eq(params[:name])
    expect(items['data']['attributes']['description']).to eq(params[:description])
    expect(items['data']['attributes']['unit_price']).to eq(params[:unit_price])
  end

end
