# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160326012841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: true do |t|
    t.integer  "user_id"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "content_name"
    t.string   "filename"
    t.string   "url"
    t.text     "content_meta"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contactables", force: true do |t|
    t.integer  "contact_id"
    t.string   "contactable_type"
    t.integer  "contactable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.integer  "user_id"
    t.string   "contact_type"
    t.string   "first_name"
    t.string   "company"
    t.string   "email"
    t.string   "phone"
    t.integer  "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
  end

  create_table "dynamic_forms_engine_dynamic_form_entries", force: true do |t|
    t.integer  "dynamic_form_type_id"
    t.text     "properties"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "signature"
    t.boolean  "in_progress"
    t.string   "last_section_saved"
    t.string   "application_pdf"
    t.binary   "social_security"
    t.binary   "social_security_key"
    t.binary   "social_security_iv"
    t.boolean  "app_fee_paid"
  end

  create_table "dynamic_forms_engine_dynamic_form_fields", force: true do |t|
    t.integer  "dynamic_form_type_id"
    t.integer  "field_order"
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.text     "content_meta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "included_in_report"
    t.string   "field_width"
  end

  create_table "dynamic_forms_engine_dynamic_form_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "form_type"
    t.boolean  "is_public"
  end

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id"
    t.text     "report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "dynamic_form_entry_id"
    t.string   "braintree_id"
    t.string   "payment_type"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "role"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
