# frozen_string_literal: true

class Page < ApplicationRecord
  has_composite_content :main
  has_composite_content :aside
end
