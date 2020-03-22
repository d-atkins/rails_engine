class Api::V1::Revenue::RevenueController < ApplicationController
  def show
    revenue = Merchant.revenue_across(params[:start], params[:end])
    render json: {data: {'id' => nil, attributes: {revenue: revenue}}}
  end
end
