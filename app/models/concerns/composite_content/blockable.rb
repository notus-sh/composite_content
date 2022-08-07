# frozen_string_literal: true

module CompositeContent
  # Concrete block types namespace.
  module Blockable
    extend ActiveSupport::Concern

    included do
      has_one :block, as: :blockable, touch: true
    end
  end
end
