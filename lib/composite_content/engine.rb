# frozen_string_literal: true

require 'rails'
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

    initializer 'composite_content.active_record' do |_app|
      ::ActiveSupport.on_load :active_record do
        require 'composite_content/orm/activerecord'
        include CompositeContent::ORM::ActiveRecord
      end
    end
  end
end
