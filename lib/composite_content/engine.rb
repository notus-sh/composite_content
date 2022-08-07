# frozen_string_literal: true

require 'acts_as_list'

module CompositeContent
  class Engine < ::Rails::Engine
    isolate_namespace CompositeContent

    # Allowed block types
    config.block_types = %w(
      CompositeContent::Blocks::Heading
      CompositeContent::Blocks::Quote
      CompositeContent::Blocks::Text
    )
  end
end
