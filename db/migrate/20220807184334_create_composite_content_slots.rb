# frozen_string_literal: true

class CreateCompositeContentSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :composite_content_slots do |t|
      t.string :type,
               null: false,
               index: true

      t.references :parent,
                   polymorphic: true,
                   index: { name: 'index_composite_content_slots_on_parent' }

      t.timestamps
    end
  end
end
