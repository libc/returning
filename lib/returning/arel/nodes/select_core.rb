module Returning
  module Arel
    module Nodes
      module SelectCore
        attr_accessor :returnings

        def initialize_copy other
          super
          @returnings = @returnings.clone if @returnings
        end
      end
    end
  end
end