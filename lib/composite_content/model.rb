# frozen_string_literal: true

module CompositeContent
  module Model # :nodoc:
    extend ActiveSupport::Autoload

    autoload :Base
    autoload :Blockable
    autoload :Builder
  end
end
