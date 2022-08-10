# frozen_string_literal: true

module CompositeContent
  module ActiveRecord
    class SlotAssociation
      def initialize(base, name, options)
        @base = base
        @name = name
        @options = options
      end

      def setup_association
        slot_name = name

        base.has_one name, -> { where(name: slot_name) }, **association_options
        base.accepts_nested_attributes_for name, reject_if: :all_blank
      end

      def setup_method
        slot_name = name

        base.define_method slot_name do
          send("#{slot_name}=", CompositeContent::Slot.new(name: slot_name, parent: self)) if super().blank?
          super()
        end
      end

      protected

      attr_reader :base, :name, :options

      def association_options
        options.dup.merge mandatory_options
      end

      def mandatory_options
        {
          class_name: CompositeContent::Slot.name,
          as: :parent,
          dependent: :destroy
        }
      end
    end
  end
end
