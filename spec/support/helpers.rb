# frozen_string_literal: true

module Helpers
  module ActiveRecord
    def dummy_model(model_name, based_on: ::ActiveRecord::Base)
      klass = Class.new(based_on) do
        yield if block_given?
      end

      # rubocop:disable Style/DocumentDynamicEvalDefinition
      klass.class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def name
          "#{model_name}"
        end
      RUBY
      # rubocop:enable Style/DocumentDynamicEvalDefinition

      stub_const(model_name, klass)
      klass
    end
  end
end

RSpec.configure do |c|
  c.include Helpers::ActiveRecord
end
