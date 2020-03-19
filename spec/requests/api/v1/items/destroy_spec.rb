require 'rails_helper'

describe 'Items API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends the info of a deleted item' do
    expect(Item.count).to eq(16)
    expect(Item.fourth.name).to eq('Item Nemo Facere')

    delete '/api/v1/items/4'

    deleted_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(deleted_item['data']['id']).to eq('4')
    expect(deleted_item['data']['attributes']['name']).to eq('Item Nemo Facere')
    expect(Item.count).to eq(15)
    expect{Item.find(4)}.to raise_error(ActiveRecord::RecordNotFound)
  end

end
