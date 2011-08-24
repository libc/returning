require 'returning/rails31/active_record/persistence'
require 'returning/rails31/arel/crud'


Arel::SelectManager.send(:include, Returning::Rails31::Arel::Crud)
ActiveRecord::Persistence.send(:include, Returning::Rails31::ActiveRecord::Persistence)
