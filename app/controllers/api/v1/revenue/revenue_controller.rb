class Api::V1::Revenue::RevenueController < ApplicationController
  def show
    revenue = Merchant.revenue_across(params[:start], params[:end]).round(2)
    render json: {data: {'id' => nil, attributes: {revenue: revenue}}}
  end
end
