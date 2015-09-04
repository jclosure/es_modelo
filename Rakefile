require 'rubygems'
require "rake/testtask"


Rake.application.options.trace_rules = true

task default: :test
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/usage_test.rb"
end
