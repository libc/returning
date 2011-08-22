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

      def exec_with_returning(sql, binds)
        records = @_returning[1].find_by_sql("#{to_sql(sql)} RETURNING #{@_returning[0]}", binds)
        records.each { |r| r.readonly! }
        records
      end

      [:update, :delete].each do |method|
        if ::ActiveRecord::VERSION::STRING =~ /^3\.0/
          class_eval <<-RUBY, __FILE__, __LINE__+1
            def #{method}(sql, name = nil)
              if @_returning
                exec_with_returning(sql, [])
              else
                super
              end
            end
          RUBY
        else
          class_eval <<-RUBY, __FILE__, __LINE__+1
            def #{method}(sql, name = nil, binds = [])
              if @_returning
                exec_with_returning(sql, binds)
              else
                super
              end
            end
          RUBY
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
