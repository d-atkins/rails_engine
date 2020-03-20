require 'rails_helper'

describe 'Items API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends a list of items by matched attribute' do
    get '/api/v1/items/find_all?id=14'

    items = JSON.parse(response.body)
    item_ids = items['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(items['data'].length).to eq(1)
    expect(item_ids).to eq(['14'])

    get '/api/v1/items/find_all?name=Expedita'

    items = JSON.parse(response.body)
    item_ids = items['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(items['data'].length).to eq(2)
    expect(item_ids).to eq(['5', '7'])

    get '/api/v1/items/find_all?description=Sunt'

    items = JSON.parse(response.body)
    item_ids = items['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(items['data'].length).to eq(5)
    expect(item_ids).to eq(['3', '4', '5', '14', '16'])

    get '/api/v1/items/find_all?unit_price=340.18'

    items = JSON.parse(response.body)
    item_ids = items['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(items['data'].length).to eq(1)
    expect(item_ids).to eq(['10'])

    get '/api/v1/items/find_all?merchant_id=2'

    items = JSON.parse(response.body)
    item_ids = items['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(items['data'].length).to eq(6)
    expect(item_ids).to eq(['10', '11', '12', '13', '14', '15'])

    get '/api/v1/items/find_all?created_at=2012-03-27 14:53:59'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data'].length).to eq(16)

    get '/api/v1/items/find_all?updated_at=2012-03-27 14:53:59'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data'].length).to eq(16)
  end

  it 'sends a list of items by partially matched case insensitive attribute' do
    get '/api/v1/items/find_all?name=expedita'

    items = JSON.parse(response.body)
    item_ids = items['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(items['data'].length).to eq(2)
    expect(item_ids).to eq(['5', '7'])

    get '/api/v1/items/find_all?description=sunt'

    items = JSON.parse(response.body)
    item_ids = items['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(items['data'].length).to eq(5)
    expect(item_ids).to eq(['3', '4', '5', '14', '16'])
  end

  it 'sends a list of items by multiple matched attributes' do
    get '/api/v1/items/find_all?description=sunt&name=magnam'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data'].length).to eq(1)
    expect(items['data'].first['id']).to eq('16')

    get '/api/v1/items/find_all?created_at=2012-03-27 14:53:59&description=fuga'

    items = JSON.parse(response.body)
    item_ids = items['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(items['data'].length).to eq(2)
    expect(item_ids).to eq(['2', '7'])
  end

  it 'returns empty arrays for invalid searches' do
    get '/api/v1/items/find_all?name=magnam&created_at=2012-03-27 14:53 UTC'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data']).to eq([])

    get '/api/v1/items/find_all?name=Excellent'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data']).to eq([])
  end

end
