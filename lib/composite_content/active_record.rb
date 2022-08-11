# frozen_string_literal: true

module CompositeContent
  module ActiveRecord # :nodoc:
    extend ActiveSupport::Concern

    # Integration methods with ActiveRecord models
    # These methods are available on any ActiveRecord model once CompositeContent is loaded.
    #
    # rubocop:disable Naming/PredicateName
    module ClassMethods
      def has_composite_content(name = :composite_content, types: [])
        CompositeContent::Model::Builder::Block.build(self, name, types)
        slot_class = CompositeContent::Model::Builder::Slot.build(self, name, types)

        has_one name, class_name: slot_class.name, as: :parent, dependent: :destroy
        accepts_nested_attributes_for name, reject_if: :all_blank

        include Mixins.instance_mixin(name)
        extend Mixins.class_mixin(name)
      end
    end
    # rubocop:enable Naming/PredicateName

    module Mixins
      class << self
        def instance_mixin(name)
          Module.new do
            define_method name do
              super() || send(:"build_#{name}")
            end
          end
        end

        def class_mixin(name)
          Module.new do
            define_method "strong_parameters_for_#{name}" do
              reflect_on_association(name).class_name.constantize.strong_parameters
            end
          end
        end
      end
    end
  end
end
