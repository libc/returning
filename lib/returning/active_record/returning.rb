require 'active_support/concern'

module Returning
  module ActiveRecord
    module Returning
      extend ActiveSupport::Concern

      included do
        if method(:find_by_sql).arity == 1
          class_eval do
            def self.find_by_sql(sql, binds = [])
              connection.select_all(sanitize_sql(sql), "#{name} Load").collect! { |record| instantiate(record) }
            end
          end
        end
      end

      def save(options = {})
        if r = options[:returning]
          connection.returning(r, self.class) do
            super()
          end
        else
          super()
        end
      end

      def create_or_update
        if connection.returning? && !new_record?
          fields = update
          # if no attributes were changed return self
          fields == 0 ? self : fields[0]
        else
          super
        end
      end

      def destroy(options = {})
        if r = options[:returning]
          connection.returning(r, self.class) do
            super()
          end
        else
          super()
        end
      end
    end
  end
end