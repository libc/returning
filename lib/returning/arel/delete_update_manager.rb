module Returning
  module Arel
    module DeleteUpdateManager
      def returning returnings
        @ast.returnings = Nodes::Returning.new(returnings) if returnings
        self
      end
    end
  end
end