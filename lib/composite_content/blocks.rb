# frozen_string_literal: true

module CompositeContent
  module Blocks
    extend ActiveSupport::Autoload

    autoload :Heading
    autoload :Quote
    autoload :Text
  end
end
