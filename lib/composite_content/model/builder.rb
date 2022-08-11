# frozen_string_literal: true

module CompositeContent
  module Model
    module Builder # :nodoc:
      extend ActiveSupport::Autoload

      autoload :Base
      autoload :Block
      autoload :Slot
    end
  end
end
