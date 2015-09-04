
load 'modelo.rb'

require 'searchkick'



ENV["ELASTICSEARCH_URL"] = "http://localhost:9200"



## enhance models

class Store
  searchkick
end

class Product
  searchkick
end
