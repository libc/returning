module Returning
  module Arel
    module Nodes
      class Returning < ::Arel::Nodes::Node
        attr_accessor :returnings

        def initialize(returnings)
          @returnings = returnings
        end

        def initialize_copy other
          super
          @returnings = @returnings.clone if @returnings
        end
      end
    end
  end
end