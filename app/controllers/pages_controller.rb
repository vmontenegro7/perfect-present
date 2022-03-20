class PagesController < ApplicationController
  before_action :request_module
  skip_before_action :authenticate_user!, only: :home
  def home; end

  def category
    @hobbies = params[:hobby]
    @age_range = params[:age_range]
    @hobbies_category_match = {
      "collectables" => ["Antiguidades e Coleções", "Livros, Revistas e Comics"],
      "DIY" => ["Arte, Papelaria e Armarinho","Ferramentas"],
      "Fitness" => ["Beleza e Cuidado Pessoal", "Esportes e Fitness"],
      "Social Media" => ["Beleza e Cuidado Pessoal","Câmeras e Acessórios","Celulares e Telefones"],
      "Self-care" => ["Beleza e Cuidado Pessoal", "Esportes e Fitness"],
      "It's a baby" => ["Bebês"],
      "Playing with friends" => ["Brinquedos e Hobbies"],
      "Fashion" => ["Calçados, Roupas e Bolsas","Joias e Relógios"],
      "Going out" => ["Calçados, Roupas e Bolsas","Joias e Relógios"],
      "Outdoor activities" => ["Câmeras e Acessórios", "Esportes e Fitness"],
      "Throwing parties" => ["Casa, Móveis e Decoração","Festas e Lembrancinhas","Instrumentos Musicais"],
      "Having people over" => ["Casa, Móveis e Decoração","Eletrodomésticos","Festas e Lembrancinhas","Instrumentos Musicais"],
      "Homebody" => ["Casa, Móveis e Decoração","Games"],
      "Cooking" => ["Eletrodomésticos"],
      "Binge watching" => ["Eletrônicos, Áudio e Vídeo","Música, Filmes e Seriados"],
      "Geek" => ["Games", "Informática", "Livros, Revistas e Comics", "Música, Filmes e Seriados"]
      }
      @ages_category_match = {
        "Baby" => ["Bebês"],
        "Children" => [ "Brinquedos e Hobbies", "Games"],
        "Teenager" => [ "Livros, Revistas e Comics","Games",
                        "Arte, Papelaria e Armarinho","Câmeras e Acessórios",
                        "Celulares e Telefones", "Calçados, Roupas e Bolsas",
                        "Instrumentos Musicais", "Música, Filmes e Seriados"],
        "Adult" => [
          "Antiguidades e Coleções", "Arte, Papelaria e Armarinho",
          "Beleza e Cuidado Pessoal","Brinquedos e Hobbies",
          "Calçados, Roupas e Bolsas","Câmeras e Acessórios",
          "Casa, Móveis e Decoração", "Celulares e Telefones",
          "Eletrodomésticos", "Eletrônicos, Áudio e Vídeo",
          "Esportes e Fitness","Ferramentas", "Festas e Lembrancinhas",
          "Games", "Informática","Instrumentos Musicais","Joias e Relógios",
          "Livros, Revistas e Comics","Música, Filmes e Seriados"
        ],
        "Elderly" => ["Antiguidades e Coleções", "Câmeras e Acessórios", "Casa, Móveis e Decoração",
                      "Eletrodomésticos", "Instrumentos Musicais", "Livros, Revistas e Comics"]
      }
    @selected_categories = @hobbies_category_match.select do |hobby, _category_|
      @hobbies.include?(hobby)
    end

    @selected_categories_by_age = @ages_category_match.select do |age_range, _category_|
      # @ages_category_match.include?(@age_range)
      age_range == @age_range
    end
    @selected_categories_final = []
    @selected_categories_final = @selected_categories.values[0].select do |category|
      @selected_categories_by_age[@age_range].include?(category)
    end
      # @hobbies.select{|hobby| }
      # @selected_categories_names = []
      # @selected_categories.values.each_with_index{|value| value.each{|item| @selected_categories_names.push(item) }}
      # @selected_categories_names
    @categories = request_api
    @categories = @categories["categories"].select do |category|
      # @selected_categories_names.include?(category["name"])
      @selected_categories_final.include?(category["name"])
    end
    # i = 0
    # while i < @categories["categories"].size
    #   @categories["categories"][i]["name"]
    #   i = i + 1
    # end
    # @categories = @categories.sample(3)
    @icons_array = {
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
    "MLB1953"=> nil
    }

    @icons_array = @icons_array.select do |_api_id_, icon_class|
      icon_class.nil? == false
    end

    # @categories = @categories["categories"].select do |category|
    #   @icons_array.include?(category["id"])
    # end
    @price_range = params[:price_range]
    @categories_array = [@categories, @icons_array, @price_range]
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
