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

ActiveRecord::Schema[7.1].define(version: 2024_04_09_200906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "cat_name"
  end

  create_table "furnitures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "person_name", default: "", null: false
    t.string "person_last_name", default: "", null: false
    t.string "person_middle_name"
    t.string "title_manufacturer", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.index ["email"], name: "index_manufacturers_on_email", unique: true
    t.index ["phone_number"], name: "index_manufacturers_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_manufacturers_on_reset_password_token", unique: true
    t.index ["title_manufacturer"], name: "index_manufacturers_on_title_manufacturer", unique: true
  end

  create_table "manufactures", force: :cascade do |t|
    t.string "manufacture_name"
    t.string "manufacture_country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_sets", force: :cascade do |t|
    t.bigint "prod_set_id", null: false
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prod_set_id"], name: "index_order_sets_on_prod_set_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "prod_sets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "set_name"
    t.hstore "prod_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_prod_sets_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "furniture_id", null: false
    t.bigint "manufacturer_id", null: false
    t.bigint "sub_category_id", null: false
    t.string "prod_model"
    t.decimal "price"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "delivery_days", default: [], array: true
    t.integer "production_days"
    t.index ["furniture_id"], name: "index_products_on_furniture_id"
    t.index ["manufacturer_id"], name: "index_products_on_manufacturer_id"
    t.index ["sub_category_id"], name: "index_products_on_sub_category_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "subcat_name"
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "middle_name"
    t.string "phone_number", default: "", null: false
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "order_sets", "prod_sets"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "prod_sets", "users"
  add_foreign_key "products", "furnitures"
  add_foreign_key "products", "manufacturers"
  add_foreign_key "products", "sub_categories"
  add_foreign_key "sub_categories", "categories"
end
