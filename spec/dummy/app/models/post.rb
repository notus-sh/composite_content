# frozen_string_literal: true

class Post < ApplicationRecord
  has_composite_content_slot :content
end
