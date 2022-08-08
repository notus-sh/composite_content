# frozen_string_literal: true

module CompositeContent
  # Blocks slot, when a model can have multiple collections of them.
  class Slot < ActiveRecord::Base
    belongs_to :parent, polymorphic: true
    has_composite_content
  end
end
