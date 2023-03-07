# frozen_string_literal: true

class CreateCompositeContentQuotes < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :composite_content_quotes do |t|
      t.text :content
      t.string :source

      t.timestamps
    end
  end
end
