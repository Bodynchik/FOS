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

ActiveRecord::Schema[7.1].define(version: 2024_03_23_164104) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "product_id", null: false
    t.integer "prod_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_carts_on_client_id"
    t.index ["product_id"], name: "index_carts_on_product_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "cat_name"
  end

  create_table "clients", force: :cascade do |t|
    t.string "client_name"
    t.string "client_surname"
    t.string "client_midname"
    t.string "user_role"
    t.string "email"
    t.string "password"
    t.string "phone"
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
    t.string "manufacture_country"
  end

  create_table "ordered_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "prod_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_ordered_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "order_date"
    t.string "postcode"
    t.integer "order_total_val"
    t.string "order_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "payment_method"
    t.integer "transaction_id"
    t.string "payment_status"
    t.datetime "payment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "prod_raitings", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "client_id", null: false
    t.integer "raiting_val"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_prod_raitings_on_client_id"
    t.index ["product_id"], name: "index_prod_raitings_on_product_id"
  end

  create_table "prod_reviews", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "client_id", null: false
    t.text "review_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_prod_reviews_on_client_id"
    t.index ["product_id"], name: "index_prod_reviews_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "sub_category_id", null: false
    t.string "prod_name"
    t.decimal "prod_price"
    t.bigint "manufacture_id", null: false
    t.text "prod_desc"
    t.integer "prod_avail_amount"
    t.decimal "prod_raiting"
    t.index ["manufacture_id"], name: "index_products_on_manufacture_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "middle_name"
    t.string "phone_number", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carts", "clients"
  add_foreign_key "carts", "products"
  add_foreign_key "ordered_products", "products"
  add_foreign_key "orders", "clients"
  add_foreign_key "payments", "orders"
  add_foreign_key "prod_raitings", "clients"
  add_foreign_key "prod_raitings", "products"
  add_foreign_key "prod_reviews", "clients"
  add_foreign_key "prod_reviews", "products"
  add_foreign_key "products", "manufactures"
  add_foreign_key "products", "sub_categories"
  add_foreign_key "sub_categories", "categories"
end
