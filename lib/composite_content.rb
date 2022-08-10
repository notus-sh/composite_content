# frozen_string_literal: true

require 'composite_content/version'
require 'composite_content/engine'
require 'composite_content/active_record'

module CompositeContent # :nodoc:
  class << self
    def blocks_attributes
      { blocks_attributes: [:id, :position, :blockable_type, :_destroy, { blockable_attributes: blockable_attributes }] }
    end

    protected

    def blockable_attributes
      blockable_column_names - %i[created_at updated_at]
    end

    def blockable_column_names
      blockable_types.collect { |type| type.column_names }.flatten.uniq.collect(&:to_sym)
    end

    def blockable_types
      Engine.config.block_types.collect(&:constantize)
    end
  end
end
