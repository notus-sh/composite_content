# frozen_string_literal: true

module CompositeContent
  module ActiveRecord
    class BlocksAssociation
      def initialize(base, name, options)
        @base = base
        @name = name
        @options = options
      end

      def setup_association
        base.has_many name, -> { order(position: :asc) }, **association_options
        base.accepts_nested_attributes_for name, allow_destroy: true, reject_if: :all_blank
      end

      protected

      attr_reader :base, :name, :options

      def association_options
        options.dup.merge mandatory_options
      end

      def mandatory_options
        {
          class_name: CompositeContent::Block.name,
          as: :parent,
          dependent: :destroy
        }
      end
    end
  end
end
