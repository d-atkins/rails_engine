class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.search(request.query_parameters).take
    render json: ItemSerializer.new(item)
  end
end
