# frozen_string_literal: true

class CreateCompositeContentSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :composite_content_slots do |t|
      t.references :parent,
                   polymorphic: true,
                   index: { name: 'index_composite_content_slots_on_parent' }

      t.string :name

      t.timestamps

      t.index %i[name]
    end
  end
end
