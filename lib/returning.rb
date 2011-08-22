require 'active_record'
require 'active_record/connection_adapters/postgresql_adapter'

require "returning/version"
require 'returning/active_record/returning'
require 'returning/active_record/adapter'


module Returning
  # Your code goes here...
end


ActiveRecord::Base.send(:include, Returning::ActiveRecord::Returning)
ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, Returning::ActiveRecord::Adapter)