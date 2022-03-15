class PresentsController < ApplicationController
  before_action :request_module, only: %i[index show]
  def index
    @products = request_api
    @products = @products.sample(3)
  end

  def show
    @products = request_api
    @product = @products[params[:id].to_i-1]
  end

  private
  def request_api
    url = "https://web.archive.org/web/20220203090926/https://fakestoreapi.com/products"
    products_serialized = URI.open(url).read
    JSON.parse(products_serialized)
  end

  def request_module
    require 'open-uri'
  end
end