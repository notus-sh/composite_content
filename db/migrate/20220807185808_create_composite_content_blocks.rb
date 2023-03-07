# frozen_string_literal: true

class CreateCompositeContentBlocks < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :composite_content_blocks do |t|
      t.references :slot
      t.references :blockable, polymorphic: true,
                               index: { name: 'index_composite_content_blocks_on_blockable' }
      t.integer :position, index: true

      t.timestamps
    end
  end
end
