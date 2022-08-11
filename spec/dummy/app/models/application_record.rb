# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  # Compatibility with Rails < 7.0
  if respond_to?(:primary_abstract_class)
    primary_abstract_class
  else
    self.abstract_class = true
  end
end
