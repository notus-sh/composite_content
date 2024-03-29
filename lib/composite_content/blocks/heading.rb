# frozen_string_literal: true

module CompositeContent
  module Blocks
    # Heading block
    class Heading < ::CompositeContent::Model::Base
      include ::CompositeContent::Model::Blockable

      validates :level,
                presence: true,
                numericality: {
                  allow_blank: true,
                  only_integer: true,
                  greater_than_or_equal_to: 1,
                  less_than_or_equal_to: 6
                }

      validates :content,
                presence: true
    end
  end
end
