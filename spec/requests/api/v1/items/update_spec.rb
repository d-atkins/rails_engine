require 'rails_helper'

describe 'Items API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends the new info of an updated item' do
    expect(Item.last.name).to eq('Item Ghost Magnam')
    expect(Item.last.unit_price).to eq(123.45)

    item_params = {name: 'Ghost Goods', unit_price: 250}
    old_description = Item.last.description
    patch '/api/v1/items/16', params: item_params

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data']['id']).to eq('16')
    expect(items['data']['attributes']['name']).to eq(item_params[:name])
    expect(items['data']['attributes']['description']).to eq(old_description)
    expect(items['data']['attributes']['unit_price']).to eq(250)

    expect(Item.last.id).to eq(16)
    expect(Item.last.name).to eq(item_params[:name])
  end

end
