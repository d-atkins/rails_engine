require 'rails_helper'

describe 'Items API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends one items by id' do
    get '/api/v1/items/16'

    items = JSON.parse(response.body)
    last = Item.last

    expect(response).to be_successful
    expect(items['data']['id']).to eq('16')
    expect(items['data']['attributes']['name']).to eq(last.name)
    expect(items['data']['attributes']['description']).to eq(last.description)
    expect(items['data']['attributes']['unit_price']).to eq(last.unit_price)
  end

end
