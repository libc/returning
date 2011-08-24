require 'active_record'
require 'active_record/connection_adapters/postgresql_adapter'

require "returning/version"
if ActiveRecord::VERSION::STRING =~ /^3\.0/
  require 'returning/rails30/returning'
elsif ActiveRecord::VERSION::STRING =~ /^3\.1/
  require 'returning/rails31/returning'
else
  raise "ActiveRecord version #{ActiveRecord::VERSION::STRING} is not supported!"
end

require 'returning/active_record/returning'
require 'returning/arel/tree_manager'
require 'returning/arel/nodes/select_core'
require 'returning/arel/nodes/returning'
require 'returning/arel/delete_update_manager'
require 'returning/arel/nodes/delete_update_statement'
require 'returning/arel/visitors/postgresql'

ActiveRecord::Base.send(:include, Returning::ActiveRecord::Returning)
Arel::SelectManager.send(:include, Returning::Arel::TreeManager)
Arel::UpdateManager.send(:include, Returning::Arel::DeleteUpdateManager)
Arel::DeleteManager.send(:include, Returning::Arel::DeleteUpdateManager)
Arel::Nodes::SelectCore.send(:include, Returning::Arel::Nodes::SelectCore)
Arel::Nodes::UpdateStatement.send(:include, Returning::Arel::Nodes::DeleteUpdateStatement)
Arel::Nodes::DeleteStatement.send(:include, Returning::Arel::Nodes::DeleteUpdateStatement)
Arel::Visitors::PostgreSQL.send(:include, Returning::Arel::Visitors::PostgreSQL)
