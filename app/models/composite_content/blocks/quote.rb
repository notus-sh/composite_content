# frozen_string_literal: true

module CompositeContent
  module Blocks
    class Quote < ActiveRecord::Base
      include CompositeContent::Blockable

      validates :content,
                presence: true
    end
  end
end
