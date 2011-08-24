require 'active_support/concern'

module Returning
  module ActiveRecord
    module Returning
      def save(options = {})
        if r = options[:returning]
          begin
            old_returning, @_returning = @_returning, r
            super
          ensure
            @_returning = old_returning
          end
        else
          super
        end
      end

      def create_or_update
        if @_returning
          raise ReadOnlyRecord if readonly?
          if new_record?
            create
            self
          elsif r = update
            r = self.class.send(:instantiate, r[0])
            r.readonly!
            r
          else
            false
          end
        else
          super
        end
      end

      def destroy(options = {})
        if r = options[:returning]
          begin
            old_returning, @_returning = @_returning, r
            if r = super()
              r = self.class.send(:instantiate, r[0])
              r.readonly!
            end

            r
          ensure
            @_returning = old_returning
          end
        else
          super()
        end
      end
    end
  end
end