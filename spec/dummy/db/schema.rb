# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_07_191410) do
  create_table "composite_content_blocks", force: :cascade do |t|
    t.string "parent_type"
    t.integer "parent_id"
    t.string "blockable_type"
    t.integer "blockable_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blockable_type", "blockable_id"], name: "index_composite_content_blocks_on_blockable"
    t.index ["parent_type", "parent_id"], name: "index_composite_content_blocks_on_parent"
    t.index ["position"], name: "index_composite_content_blocks_on_position"
  end

  create_table "composite_content_headings", force: :cascade do |t|
    t.integer "level", default: 1, null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "composite_content_quotes", force: :cascade do |t|
    t.text "content"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "composite_content_texts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
