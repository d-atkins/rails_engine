require 'rails_helper'

describe 'Merchants API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends one merchant by matched name' do
    get '/api/v1/merchants/find?name=Ghost'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq('3')
    expect(merchant['data']['attributes']['name']).to eq('Ghost Shop')
  end

  it 'sends one merchant by partially matched case insensitive name' do
    get '/api/v1/merchants/find?name=jerde'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq('1')
    expect(merchant['data']['attributes']['name']).to eq('Schroeder-Jerde')
  end

  it 'sends one merchant by multiple matched parameters' do
    get '/api/v1/merchants/find?name=jerde&id=1'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq('1')
    expect(merchant['data']['attributes']['name']).to eq('Schroeder-Jerde')
  end

end
