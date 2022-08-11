# frozen_string_literal: true

require 'rails'
require 'active_model_validations_reflection'
require 'acts_as_list'
require 'cocooned'

module CompositeContent
  class Engine < ::Rails::Engine # :nodoc:
    # Configurable engine options
    #
    # Feel free to adjust these settings in a initializer in your application.
    # Ex:
    #
    #     # In config/initializers/composite_content.rb
    #     require 'composite_content'
    #     CompositeContent::Engine.config.block_types += %w[CompositeContent::Blocks::Image]

    # Allowed block types
    config.block_types = %w[
      CompositeContent::Blocks::Heading
      CompositeContent::Blocks::Quote
      CompositeContent::Blocks::Text
    ]

    # Engine internals
    #
    # Following configurations are here for engine initialization and internal
    # configurations and are not meant to be changed by your application.

    # Isolate models (and their tables) in their own namespace.
    isolate_namespace CompositeContent

    config.i18n.load_path += Dir[root.join('config', 'locales', '**', '*.{rb,yml}')]

    initializer 'composite_content.active_record' do |_app|
      ::ActiveSupport.on_load :active_record do
        require 'composite_content/active_record'
        include CompositeContent::ActiveRecord
      end
    end

    initializer 'composite_content.action_view' do |_app|
      ActiveSupport.on_load :action_view do
        require 'composite_content/action_view'
        include CompositeContent::ActionView
      end
    end
  end
end
