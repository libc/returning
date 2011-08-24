module Returning
  module Arel
    module Visitors
      module PostgreSQL
        private
        def visit_Returning_Arel_Nodes_Returning o
          if o.returnings.empty?
            ""
          else
            " RETURNING #{o.returnings.join(', ')}"
          end
        end

        def visit_Arel_Nodes_UpdateStatement o
          if o.returnings
            "#{super}#{visit o.returnings}"
          else
            super
          end
        end

        def visit_Arel_Nodes_DeleteStatement o
          if o.returnings
            "#{super}#{visit o.returnings}"
          else
            super
          end
        end
      end
    end
  end
end