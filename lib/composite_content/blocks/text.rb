# frozen_string_literal: true

module CompositeContent
  module Blocks
    # Text block
    class Text < ::CompositeContent::Model::Base
      include ::CompositeContent::Model::Blockable

      validates :content,
                presence: true
    end
  end
end
