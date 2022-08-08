# frozen_string_literal: true

module CompositeContent
  # Shared block behaviors
  module Blockable
    extend ActiveSupport::Concern

    included do
      has_one :block,
              as: :blockable,
              inverse_of: :blockable,
              touch: true,
              dependent: :destroy
    end
  end
end
