class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.search(request.query_parameters).take
    render json: MerchantSerializer.new(merchant)
  end
end
