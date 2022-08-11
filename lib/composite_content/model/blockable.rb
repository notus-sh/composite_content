# frozen_string_literal: true

module CompositeContent
  module Model
    # Shared behaviors for concrete block implementations
    module Blockable
      extend ActiveSupport::Concern

      included do
        has_one :block,
                as: :blockable,
                touch: true,
                dependent: :destroy
      end

      def block_type
        self.class.name.demodulize.underscore
      end
    end
  end
end
