class PresentsController < ApplicationController
  before_action :request_module, only: %i[index show]
  def index
    @price_range = params[:price_range]
    @products = request_api(params[:category_id], nil)
      if @price_range == "R$ 0 - 100"
        @products = @products["results"].select do |product|
          product["price"] > 0 && product["price"] < 100
        end
      elsif @price_range == "R$ 100 - 300"
        @products = @products["results"].select do |product|
          product["price"] >= 100 && product["price"] < 300
        end
      elsif @price_range == "R$ 300 - 500"
        @products = @products["results"].select do |product|
          product["price"] >= 300 && product["price"] < 500
        end
      elsif @price_range == "R$ 500+"
        @products = @products["results"].select do |product|
          product["price"] >= 500
        end
      else
        @products = request_api(params[:category_id], nil)
      end
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
