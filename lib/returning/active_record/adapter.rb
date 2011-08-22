module Returning
  module ActiveRecord
    module Adapter
      def to_sql(arel)
        if arel.respond_to?(:ast)
          visitor.accept(arel.ast)
        else
          arel
        end
      end

      def returning?
        !!@_returning
      end

      def update(sql, name = nil, binds = [])
        if @_returning
          records = @_returning[1].find_by_sql("#{to_sql(sql)} RETURNING #{@_returning[0]}", binds)
          records.each { |r| r.readonly! }
          records
        else
          super
        end
      end

      def delete(arel, name = nil, binds = [])
        if @_returning
          records = @_returning[1].find_by_sql("#{to_sql(arel)} RETURNING #{@_returning[0]}", binds)
          records.each { |r| r.readonly! }
          records
        else
          super
        end
      end


      def returning(columns, klass)
        old_returning, @_returning = @_returning, [columns, klass]
        yield
      ensure
        @_returning = old_returning
      end
    end
  end
end
