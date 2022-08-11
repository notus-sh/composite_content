# frozen_string_literal: true

require 'composite_content/version'
require 'composite_content/engine'
require 'composite_content/model'
require 'composite_content/active_record'

module CompositeContent # :nodoc:
  extend ActiveSupport::Autoload

  autoload :Block
  autoload :Blocks
  autoload :Slot
end
