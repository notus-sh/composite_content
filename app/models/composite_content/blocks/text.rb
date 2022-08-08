# frozen_string_literal: true

module CompositeContent
  module Blocks
    class Text < ActiveRecord::Base
      include CompositeContent::Blockable

      validates :content,
                presence: true
    end
  end
end
