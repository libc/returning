module Returning
  module Rails30
    module Arel
      module Crud
        def update values
          um = ::Arel::UpdateManager.new @engine

          if ::Arel::Nodes::SqlLiteral === values
            relation = @ctx.froms
          else
            relation = values.first.first.relation
          end
          um.table relation
          um.set values
          um.take @ast.limit.expr if @ast.limit
          um.order(*@ast.orders)
          um.wheres = @ctx.wheres
          um.returning @ctx.returnings if @ctx.returnings

          if @ctx.returnings
            @engine.connection.select_all um.to_sql, 'AREL'
          else
            @engine.connection.update um.to_sql, 'AREL'
          end
        end

        def delete
          dm = ::Arel::DeleteManager.new @engine
          dm.wheres = @ctx.wheres
          dm.from @ctx.froms
          dm.returning @ctx.returnings if @ctx.returnings

          if @ctx.returnings
            @engine.connection.select_all dm.to_sql, 'AREL'
          else
            @engine.connection.delete dm.to_sql, 'AREL'
          end
        end
      end
    end
  end
end