module Returning
  module Rails30
    module ActiveRecord
      module Persistence
        extend ActiveSupport::Concern
        included do
          def update(attribute_names = @attributes.keys, options = {})
            attributes_with_values = arel_attributes_values(false, false, attribute_names)
            return @_returning ? [@attributes] : 0 if attributes_with_values.empty?
            self.class.unscoped.where(self.class.arel_table[self.class.primary_key].eq(id)).arel.returning(@_returning).update(attributes_with_values)
          end

          def destroy
            destroy_associations

            if persisted?
              result = self.class.unscoped.where(self.class.arel_table[self.class.primary_key].eq(id)).arel.returning(@_returning).delete
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