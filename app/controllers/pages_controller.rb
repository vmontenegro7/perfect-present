class PagesController < ApplicationController
  before_action :request_module
  skip_before_action :authenticate_user!, only: :home
  def home; end

  def category
    @categories = request_api
    # @categories = @categories.sample(3)
    @icons_array =  {
    "MLB5672"=>"fa-solid fa-car",
    "MLB271599"=> nil,
    "MLB1403"=>"fa-solid fa-burger",
    "MLB1071"=>"fa-solid fa-paw",
    "MLB1367"=>"fa-solid fa-building-columns",
    "MLB1368"=>"fa-solid fa-book",
    "MLB1384"=>"fa-solid fa-baby",
    "MLB1246"=>"fa-solid fa-spray-can-sparkles",
    "MLB1132"=>"fa-solid fa-person-snowboarding",
    "MLB1430"=>"fa-solid fa-shirt",
    "MLB1039"=>"fa-solid fa-camera-retro",
    "MLB1743"=> nil,
    "MLB1574"=>"fa-solid fa-couch",
    "MLB1051"=>"fa-solid fa-mobile-screen-button",
    "MLB1500"=>"fa-solid fa-shower",
    "MLB5726"=>"fa-solid fa-blender",
    "MLB1000"=>"fa-solid fa-tv",
    "MLB1276"=>"fa-solid fa-weight-hanging",
    "MLB263532"=>"fa-solid fa-screwdriver-wrench",
    "MLB12404"=>"fa-solid fa-cake-candles",
    "MLB1144"=>"fa-solid fa-gamepad",
    "MLB1459"=> nil,
    "MLB1499"=> nil,
    "MLB1648"=>"fa-solid fa-laptop",
    "MLB218519"=> nil,
    "MLB1182"=>"fa-solid fa-guitar",
    "MLB3937"=>"fa-solid fa-ring",
    "MLB1196"=>"fa-solid fa-book-open-reader",
    "MLB1168"=>"fa-solid fa-clapperboard",
    "MLB264586"=> nil,
    "MLB1540"=> nil,
    "MLB1953"=> nil}
    @categories_array = [@categories, @icons_array]
  end

  private
  def request_api
    # url = "https://web.archive.org/web/20220203090926/https://fakestoreapi.com/products/categories"
    url = "https://api.mercadolibre.com/sites/MLB#json"
    categories_serialized = URI.open(url).read
    JSON.parse(categories_serialized)
  end

  def request_module
    require 'open-uri'
  end
end
