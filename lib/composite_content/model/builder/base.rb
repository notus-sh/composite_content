# frozen_string_literal: true

module CompositeContent
  module Model
    module Builder
      class Base # :nodoc:
        BLOCK_SUFFIX = 'Block'
        SLOT_SUFFIX = 'Slot'

        class << self
          def build(parent, association, types = [])
            self.new.build(parent, association, types)
          end
        end

        def build(parent, association, types = [])
          demodulized = build_classname(parent, association).demodulize

          parent.const_set(demodulized, build_class(parent, association, types))
          parent.const_get(demodulized)
        end

        def build_class(_parent, _association, _types = [])
          raise NotImplementedError
        end

        def build_classname(_parent, _association)
          raise NotImplementedError
        end

        protected

        def classname_for_slot(parent, association)
          classname_for(parent, association, SLOT_SUFFIX)
        end

        def classname_for_block(parent, association)
          classname_for(parent, association, BLOCK_SUFFIX)
        end

        def classname_for(parent, association, suffix)
          [parent.model_name.to_s, [association.to_s.singularize.classify, suffix].join].join('::')
        end
      end
    end
  end
end
