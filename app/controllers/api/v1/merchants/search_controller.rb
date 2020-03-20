class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchant = Merchant.search(request.query_parameters)
    render json: MerchantSerializer.new(merchant)
  end

  def show
    merchant = Merchant.search(request.query_parameters).take
    render json: MerchantSerializer.new(merchant)
  end
end
