# frozen_string_literal: true

class Page < ApplicationRecord
  has_composite_content_slots :main, :aside
end
