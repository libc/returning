module Returning
  module Rails31
    module Arel
      module Crud
        def compile_update values
          um = ::Arel::UpdateManager.new @engine

          if ::Arel::Nodes::SqlLiteral === values
            relation = @ctx.from
          else
            relation = values.first.first.relation
          end
          um.table relation
          um.set values
          um.take @ast.limit.expr if @ast.limit
          um.order(*@ast.orders)
          um.wheres = @ctx.wheres
          um.returning @ctx.returnings if @ctx.returnings
          um
        end

        def compile_delete
          dm = ::Arel::DeleteManager.new @engine
          dm.wheres = @ctx.wheres
          dm.from @ctx.froms
          dm.returning @ctx.returnings if @ctx.returnings
          dm
        end
      end
    end
  end
end