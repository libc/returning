module Returning
  module Rails31
    module ActiveRecord
      module Persistence
        extend ActiveSupport::Concern
        included do
          def update(attribute_names = @attributes.keys)
            attributes_with_values = arel_attributes_values(false, false, attribute_names)
            return @_returning ? [@attributes] : 0 if attributes_with_values.empty?
            klass = self.class
            stmt = klass.unscoped.where(klass.arel_table[klass.primary_key].eq(id)).arel.returning(@_returning).compile_update(attributes_with_values)
            if @_returning
              klass.connection.select_all stmt
            else
              klass.connection.update stmt
            end
          end

          def destroy
            destroy_associations

            if persisted?
              ::ActiveRecord::IdentityMap.remove(self) if ::ActiveRecord::IdentityMap.enabled?
              pk         = self.class.primary_key
              column     = self.class.columns_hash[pk]
              substitute = connection.substitute_at(column, 0)

              relation = self.class.unscoped.where(
                self.class.arel_table[pk].eq(substitute))

              relation.bind_values = [[column, id]]
              stmt = relation.arel.returning(@_returning).compile_delete

              klass = self.class
              result = if @_returning
                klass.connection.select_all stmt, 'SQL', relation.bind_values
              else
                klass.connection.delete stmt, 'SQL', relation.bind_values
              end
            end

            @destroyed = true
            freeze

            result ? result : self
          end
        end
      end
    end
  end
end