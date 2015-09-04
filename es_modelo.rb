
load './modelo.rb'

require 'searchkick'



ENV["ELASTICSEARCH_URL"] = "http://localhost:9200"



## enhance models

class Store
  searchkick
end

class Product
  searchkick
end

 

## reindex models into es

Product.reindex
Store.reindex

## play with models
products = Product.search "apples"
products.each do |product|
  puts product.name
end

Product.search "apples", where: {in_stock: true}, limit: 10, offset: 50

# SEARCHKICK DOCUMENTATION: http://www.plugingeek.com/repos/ankane/searchkick
