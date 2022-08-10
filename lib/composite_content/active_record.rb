# frozen_string_literal: true

module CompositeContent
  module ActiveRecord # :nodoc:
    extend ActiveSupport::Concern
    extend ActiveSupport::Autoload

    autoload :BlocksAssociation
    autoload :SlotAssociation

    # Integration methods with ActiveRecord models
    # These methods are available on any ActiveRecord model once CompositeContent is loaded.
    #
    # rubocop:disable Naming/PredicateName
    module ClassMethods
      # Add a :blocks association on a model to host a blocks collection as composite content.
      def has_composite_content(name = :blocks, **options)
        association = BlocksAssociation.new(self, name.to_sym, options)
        association.setup_association
      end

      # Add a single slot on a model to host composite content, through an additional layer.
      # This can be used to add multiple slots on the same model to host multiple blocks
      # collections (i.e.: a main content and a sidebar content).
      def has_composite_content_slot(name, **options)
        association = SlotAssociation.new(self, name.to_sym, options)
        association.setup_association
        association.setup_method
      end

      # Add multiple slots on a model.
      # See has_composite_content_slot for details.
      def has_composite_content_slots(*names, **options)
        Array(names).each { |name| has_composite_content_slot(name, **options) }
      end
    end
    # rubocop:enable Naming/PredicateName
  end
end
