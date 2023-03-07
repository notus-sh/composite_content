# frozen_string_literal: true

class CreateCompositeContentTexts < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :composite_content_texts do |t|
      t.text :content

      t.timestamps
    end
  end
end
