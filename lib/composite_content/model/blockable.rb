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

      module ClassMethods
        def strong_parameters_names
          column_names.collect(&:to_sym) - %i[created_at updated_at]
        end
      end
    end
  end
end
