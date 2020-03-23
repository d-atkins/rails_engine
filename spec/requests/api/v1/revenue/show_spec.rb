require 'rails_helper'

describe 'Revenue API:', type: :request do
  before(:each) do
    importer = Importer.new
    importer.reset_all_tables('./spec/fixtures/truncated/')
  end

  it 'sends the revenue across all merchants between the given dates' do
    get '/api/v1/revenue?start=2012-03-20&end=2012-03-30'

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue['data']['id']).to eq(nil)
    expect(revenue['data']['attributes']['revenue']).to eq(22959.47)
  end

end
