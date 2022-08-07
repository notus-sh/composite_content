# frozen_string_literal: true

class CreateCompositeContentHeadings < ActiveRecord::Migration[6.0]
  def change
    create_table :composite_content_headings do |t|
      t.integer :level, null: false, default: 1
      t.string :content

      t.timestamps
    end
  end
end
