module Returning
  module Arel
    module TreeManager
      def returning *returnings
        @ctx.returnings = returnings if !returnings.compact.empty?
        self
      end
    end
  end
end