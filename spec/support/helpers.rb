# frozen_string_literal: true

module Helpers
  module ActiveRecord
    def dummy_model(model_name, based_on: ::ActiveRecord::Base)
      klass = Class.new(based_on) do
        yield if block_given?
      end

      klass.class_eval <<-RUBY
        def name
          "#{model_name}"
        end
      RUBY

      stub_const(model_name, klass)
      klass
    end
  end
end

RSpec.configure do |c|
  c.include Helpers::ActiveRecord
end
