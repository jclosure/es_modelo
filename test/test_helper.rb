require "bundler/setup"
#Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "logger"
require "searchkick"

Minitest::Test = Minitest::Unit::TestCase unless defined?(Minitest::Test)

# ensure clean logfile for es interaction
File.delete("elasticsearch.log") if File.exist?("elasticsearch.log")
Searchkick.client.transport.logger = Logger.new("elasticsearch.log")


# setup testing environment
puts "Running against Elasticsearch #{Searchkick.server_version}"
I18n.config.enforce_available_locales = true


##
# setup baseclass for all tests
##
class Minitest::Test

  def setup
    Store.destroy_all
    Product.destroy_all
  end


  ## common helpers and assertions available to every test
  protected

  def store(documents, klass = Product)
    documents.shuffle.each do |document|
      klass.create!(document)
    end
    klass.searchkick_index.refresh
  end

  def store_names(names, klass = Product)
    store names.map { |name| {name: name} }, klass
  end

  # no order
  def assert_search(term, expected, options = {}, klass = Product)
    assert_equal expected.sort, klass.search(term, options).map(&:name).sort
  end

  def assert_order(term, expected, options = {}, klass = Product)
    assert_equal expected, klass.search(term, options).map(&:name)
  end

  def assert_first(term, expected, options = {}, klass = Product)
    assert_equal expected, klass.search(term, options).map(&:name).first
  end


  
end
