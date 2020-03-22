class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).revenue
    render json: {data: {'id' => nil, attributes: {revenue: revenue}}}
  end
end
