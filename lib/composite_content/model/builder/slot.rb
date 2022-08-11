# frozen_string_literal: true

module CompositeContent
  module Model
    module Builder
      # Class builder for Slot models
      #
      # Every composite content slot is defined by its own class, subclass of CompositeContent::Slot.
      # This allows to use of a dedicated block class where we can set validations on block types and
      # to rely on ActiveRecord default behaviors for Single Table Inheritance models (as adding a
      # constraint on type to queries).
      class Slot < Base
        alias build_classname classname_for_slot

        def build_class(parent, association, _types = [])
          Class.new(CompositeContent::Slot).tap do |klass|
            klass.has_many :blocks,
                           -> { order(position: :asc) },
                           class_name: classname_for_block(parent, association),
                           foreign_key: :slot_id,
                           inverse_of: :slot,
                           dependent: :destroy

            klass.accepts_nested_attributes_for :blocks, allow_destroy: true, reject_if: :all_blank
            klass.validates_associated :blocks
          end
        end
      end
    end
  end
end
