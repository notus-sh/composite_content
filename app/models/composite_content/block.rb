# frozen_string_literal: true

module CompositeContent
  # Base class for all types of blocks.
  class Block < ::ActiveRecord::Base
    belongs_to :parent,
               polymorphic: true

    acts_as_list scope: %i[parent_id parent_type]

    # Use delegated types to handle differences between block types.
    # As blocks can be very different, this guaranties we will not end with a huge table
    # full of null values (as with single table inheritance) but we will still be able
    # to query all blocks associated to a record and their content at once.
    delegated_type :blockable,
                   types: CompositeContent::Engine.config.block_types,
                   dependent: :destroy

    accepts_nested_attributes_for :blockable,
                                  reject_if: :all_blank
  end
end
