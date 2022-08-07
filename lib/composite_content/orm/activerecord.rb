# frozen_string_literal: true

module CompositeContent
  module ORM
    module ActiveRecord
      extend ActiveSupport::Concern

      module ClassMethods
        def has_composite_content(name = :content, options = {})
          BlocksAssociationMethods.setup_association(self, name.to_sym, options)
        end

        def has_composite_content_slot(name, options = {})
          SlotAssociationMethods.setup_association(self, name.to_sym, options)

          define_method name do
            send("#{name}=", CompositeContent::Slot.new(name: name, parent: self)) unless super
            super
          end
        end
      end

      module BlocksAssociationMethods
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

      module SlotAssociationMethods
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
