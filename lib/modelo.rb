require 'rubygems'
require 'mysql2' # or 'pg' or 'sqlite3'
require 'sqlite3'
require 'active_record'
require 'active_record/base'

ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.time_zone_aware_attributes = true

## read in db config from yaml file
#ActiveRecord::Base.configurations = YAML::load(IO.read('config/database.yml'))
#ActiveRecord::Base.establish_connection("development")

## manual db configurations

## MySql
# ActiveRecord::Base.establish_connection(
#   adapter:  'mysql2', # or 'postgresql' or 'sqlite3'
#   database: 'Test',
# #  username: 'DB_USER',
# #  password: 'DB_PASS',
#   host:     'localhost'
# )

## Sqlite3
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Base.raise_in_transactional_callbacks = true if ActiveRecord::Base.respond_to?(:raise_in_transactional_callbacks=)

## create tables


ActiveRecord::Migration.create_table :stores do |t|
  t.string :name
end

ActiveRecord::Migration.create_table :products do |t|
  t.string :name
  t.integer :store_id
  t.boolean :in_stock
  t.boolean :backordered
  t.integer :orders_count
  t.decimal :found_rate
  t.integer :price
  t.string :color
  t.decimal :latitude, precision: 10, scale: 7
  t.decimal :longitude, precision: 10, scale: 7
  t.text :description
  t.timestamps null: true
end

## define models

class Store < ActiveRecord::Base
  
end

class Product < ActiveRecord::Base
  belongs_to :store
  
end

