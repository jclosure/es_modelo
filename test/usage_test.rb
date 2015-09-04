require_relative "test_helper"

require "es_modelo.rb"

class UsageTest < Minitest::Test

  def test_active_record

    ## play with models
    s = Store.create name: "store abc"

    # create red apples
    p = Product.create name: "red apples"
    p.store = s
    p.save

    puts p.to_json
    puts Product.all.to_json

    # create green apples
    p = Product.create name: "green apples"
    p.store = s
    p.save

    puts p.to_json
    puts Product.all.to_json


  end

  def test_searchkick_query
    
    store_names ["Milk", "Apple"]
    query = Product.search("milk", execute: false)
    # query.body = {query: {match_all: {}}}
    # query.body = {query: {match: {name: "Apple"}}}
    query.body[:query] = {match_all: {}}
    assert_equal ["Apple", "Milk"], query.execute.map(&:name).sort

  end

  
  def test_searchkick

    ## manually run above test to create some searchable data
    test_active_record
    
    ## reindex models into es
    
    Product.reindex
    Store.reindex

    ## play with models
    products = Product.search ["apples", "oranges"]
    products.each do |product|
      puts product.name
    end

    Product.search "apples", where: {in_stock: true}, limit: 10, offset: 50

    # SEARCHKICK DOCUMENTATION: http://www.plugingeek.com/repos/ankane/searchkick

  end

end
