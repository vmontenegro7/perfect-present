class PresentsController < ApplicationController
  before_action :request_module, only: %i[index show]
  def index
    @products = request_api(params[:category_id], nil)
    # @products = @products.sample(3)
  end

  def show
    @product = request_api(nil, params[:id])
    # @product = @products[params[:id].to_i-1]
  end

  private
  def request_api(category_id = nil, item_id = nil)
    if item_id.nil? && category_id.nil? == false
      # url = "https://web.archive.org/web/20220203090926/https://fakestoreapi.com/products"
      url = "https://api.mercadolibre.com/sites/MLB/search?category=#{category_id}#json"
      products_serialized = URI.open(url).read
      JSON.parse(products_serialized)
    else
      url = "https://api.mercadolibre.com/items/#{item_id}"
      product_serialized = URI.open(url).read
      JSON.parse(product_serialized)
    end
  end

  def request_module
    require 'open-uri'
  end
end
