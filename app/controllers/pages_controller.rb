class PagesController < ApplicationController
  before_action :request_module
  skip_before_action :authenticate_user!, only: :home
  def home; end

  def category
    @categories = request_api
    @categories = @categories.sample(3)
  end

  private
  def request_api
    url = "https://web.archive.org/web/20220203090926/https://fakestoreapi.com/products/categories"
    categories_serialized = URI.open(url).read
    JSON.parse(categories_serialized)
  end

  def request_module
    require 'open-uri'
  end
end