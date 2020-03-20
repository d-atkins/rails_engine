require 'rails_helper'

describe 'Items API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends one item by matched attribute' do
    get '/api/v1/items/find?name=Ghost'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']['id']).to eq('16')
    expect(item['data']['attributes']['name']).to eq('Item Ghost Magnam')
  end

  it 'sends one item by partially matched case insensitive attribute' do
    get '/api/v1/items/find?name=ghos'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']['id']).to eq('16')
    expect(item['data']['attributes']['name']).to eq('Item Ghost Magnam')

    get '/api/v1/items/find?description=nostrum'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']['id']).to eq('13')
    expect(item['data']['attributes']['name']).to eq('Item Voluptatem Sint')
  end

  it 'sends one item by multiple matched attributes' do
    get '/api/v1/items/find?name=magnam&unit_price=123.45'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']['id']).to eq('16')
    expect(item['data']['attributes']['name']).to eq('Item Ghost Magnam')

    get '/api/v1/items/find?created_at=2012-03-27 14:53:59&name=item'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']['id']).to eq('1')
    expect(item['data']['attributes']['name']).to eq('Item Qui Esse')
  end

  it 'returns nil for invalid searches' do
    get '/api/v1/items/find?name=magnam&unit_price=123.4'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']).to eq(nil)

    get '/api/v1/items/find?id=17'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']).to eq(nil)
  end

end
