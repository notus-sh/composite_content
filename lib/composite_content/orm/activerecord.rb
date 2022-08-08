# frozen_string_literal: true

module CompositeContent
  module ORM
    module ActiveRecord # :nodoc:
      extend ActiveSupport::Concern

      # Integration methods with ActiveRecord models
      # These methods are available on any ActiveRecord model once CompositeContent is loaded.
      #
      # rubocop:disable Naming/PredicateName
      module ClassMethods
        # Add a :blocks association on a model to host a blocks collection as composite content.
        def has_composite_content(name = :blocks, **options)
          BlocksAssociationMethods.setup_association(self, name.to_sym, options)
        end

        # Add a single slot on a model to host composite content, through an additional layer.
        # This can be used to add multiple slots on the same model to host multiple blocks
        # collections (i.e.: a main content and a sidebar content).
        def has_composite_content_slot(name, **options)
          SlotAssociationMethods.setup_association(self, name.to_sym, options)

          define_method name do
            send("#{name}=", CompositeContent::Slot.new(name: name, parent: self)) unless super
            super
          end
        end

        # Add multiple slots on a model.
        # See has_composite_content_slot for details.
        def has_composite_content_slots(*names, **options)
          Array(names).each { |name| has_composite_content_slot(name, **options) }
        end
      end
      # rubocop:enable Naming/PredicateName

      module BlocksAssociationMethods # :nodoc:
        class << self
          def setup_association(base, name, options = {})
            base.has_many name, -> { order(position: :asc) }, **association_options(options)
            base.accepts_nested_attributes_for name, allow_destroy: true, reject_if: :all_blank
          end

          protected

          def association_options(options)
            options.dup.merge mandatory_options
          end

          def mandatory_options
            {
              class_name: CompositeContent::Block.name,
              as: :parent,
              dependent: :destroy
            }
          end
        end
      end

      module SlotAssociationMethods # :nodoc:
        class << self
          def setup_association(base, name, options = {})
            base.has_one name, -> { where(name: name) }, **association_options(options)
            base.accepts_nested_attributes_for name, reject_if: :all_blank
          end

          protected

          def association_options(options)
            options.dup.merge mandatory_options
          end

          def mandatory_options
            {
              class_name: CompositeContent::Slot.name,
              as: :parent,
              dependent: :destroy
            }
          end
        end
      end
    end
  end
end
