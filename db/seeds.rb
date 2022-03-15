# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "json"
require "open-uri"
url = "https://web.archive.org/web/20220203090926/https://fakestoreapi.com/products"
presents_serialized = URI.open(url).read
presents = JSON.parse(presents_serialized)

presents.each do |present|
  present = Present.create!(
    category: present["category"],
    price: present["price"],
    description: present["description"],
    name: present["title"],
    rating: present["rating"]["rate"],
    image_url: present["image"]
  )
  puts "#{present['id']} created!"
end