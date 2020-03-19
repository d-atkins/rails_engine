require 'rails_helper'

describe 'Items API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends a list of all items' do
    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data'].length).to eq(16)
    expect(items['data'].first['id']).to eq('1')
    expect(items['data'].second['id']).to eq('2')
    expect(items['data'].last['id']).to eq('16')
  end

end
