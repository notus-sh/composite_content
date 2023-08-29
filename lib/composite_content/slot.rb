# frozen_string_literal: true

module CompositeContent
  # Slots are used as container for blocks collection.
  #
  # Whether a model as one or more composite content slots does not matter: blocks are always
  # contained in a slot. This allows to keep programming interface consistent between uses and
  # ease future integration of multiple slots on model where only one was expected at first.
  class Slot < ::CompositeContent::Model::Base
    belongs_to :parent, polymorphic: true

    # Compatibility with parent models using Single Table Inheritance.
    # See ActiveRecord::Associations::ClassMethods's overview for more detail.
    def parent_type=(class_name)
      super(class_name.constantize.base_class.to_s)
    end

    # Association with blocks is dynamically declared when building dedicated slot and
    # block classes. See CompositeContent::Model::Builder.

    class << self
      def block_class
        @block_class ||= reflect_on_association(:blocks).class_name.constantize
      end

      def blockable_classes
        @blockable_classes ||= begin
          validators = block_class.validators_on_of_kinds(:blockable_type, :inclusion)
          types = validators.collect(&:options).collect { |opts| opts.fetch(:in) }.flatten.compact.uniq
          types.collect(&:constantize)
        end
      end

      def strong_parameters
        [
          :id,
          { blocks_attributes: block_strong_parameters_names + [
            { blockable_attributes: blockable_strong_parameters_names },
            :_destroy]
          }
        ]
      end

      protected

      def block_strong_parameters_names
        @block_strong_parameters_names ||= begin
          parameters = block_class.column_names.collect(&:to_sym)
          parameters - %i[slot_id blockable_id created_at updated_at]
        end
      end

      def blockable_strong_parameters_names
        @blockable_strong_parameters_names ||= blockable_classes.collect(&:strong_parameters_names).flatten.compact.uniq
      end
    end
  end
end
