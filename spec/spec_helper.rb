require 'rubygems'
require 'bundler/setup'

Bundler.require

Dir['spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do
end
