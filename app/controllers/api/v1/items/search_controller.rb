class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Item.search(request.query_parameters)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.search(request.query_parameters).take
    render json: ItemSerializer.new(item)
  end
end
