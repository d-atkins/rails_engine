require 'rails_helper'

describe 'Merchants API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends a list of merchants by matched name' do
    get '/api/v1/merchants/find_all?name=p'

    merchants = JSON.parse(response.body)
    merchant_ids = merchants['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(merchants['data'].length).to eq(2)
    expect(merchant_ids).to eq(['2', '3'])
  end

  it 'sends a list of merchants by partially matched case insensitive name' do
    get '/api/v1/merchants/find_all?name=s'

    merchants = JSON.parse(response.body)
    merchant_ids = merchants['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(merchants['data'].length).to eq(3)
    expect(merchant_ids).to eq(['1', '2', '3'])
  end

  it 'sends a list of merchants by multiple matched parameters' do
    get '/api/v1/merchants/find_all?created_at=2012-03-27 14:53:59&name=h'

    merchants = JSON.parse(response.body)
    merchant_ids = merchants['data'].map { |hash| hash['id'] }

    expect(response).to be_successful
    expect(merchants['data'].length).to eq(2)
    expect(merchant_ids).to eq(['1', '3'])
  end

end
