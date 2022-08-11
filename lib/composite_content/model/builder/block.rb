# frozen_string_literal: true

module CompositeContent
  module Model
    module Builder
      # Class builder for Block models
      #
      # Every composite content slot as its own block class, subclass of CompositeContent::Block.
      # This allows to set distinct validations on allowed block types used in each composite
      # content.
      class Block < Base
        alias build_classname classname_for_block

        def build_class(parent, association, types = [])
          Class.new(::CompositeContent::Block).tap do |klass|
            klass.belongs_to :slot, class_name: classname_for_slot(parent, association), inverse_of: :blocks

            klass.delegated_type :blockable, types: blockable_types(types), dependent: :destroy
            klass.accepts_nested_attributes_for :blockable, reject_if: :all_blank

            klass.validates_associated :blockable
            klass.validates :blockable_type, inclusion: { in: blockable_types(types) }
          end
        end

        protected

        def blockable_types(types)
          return CompositeContent::Engine.config.block_types if types.empty?

          CompositeContent::Engine.config.block_types & types
        end
      end
    end
  end
end
