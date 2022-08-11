# frozen_string_literal: true

module CompositeContent
  module Model
    # Base class for engine's models.
    # Equivalent to ApplicationRecord in a Rails app.
    class Base < ::ActiveRecord::Base
      self.abstract_class = true

      include ActiveModel::Validations::Reflection
    end
  end
end
