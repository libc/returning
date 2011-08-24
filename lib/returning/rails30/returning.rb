require 'returning/rails30/active_record/persistence'
require 'returning/rails30/arel/crud'


Arel::SelectManager.send(:include, Returning::Rails30::Arel::Crud)
ActiveRecord::Persistence.send(:include, Returning::Rails30::ActiveRecord::Persistence)
