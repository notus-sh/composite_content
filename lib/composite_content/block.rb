# frozen_string_literal: true

module CompositeContent
  # Base class for all types of blocks.
  class Block < ::CompositeContent::Model::Base
    acts_as_list scope: :slot_id

    # Delegation to block types is dynamically declared when building dedicated slot and
    # block classes. See CompositeContent::Model::Builder.
  end
end
