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

ActiveRecord::Schema.define(version: 20160406052780) do

  create_table "account_ssh_keys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.string   "title"
    t.integer  "cat"
    t.text     "content",    limit: 65535
    t.string   "comment"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "account_ssh_keys", ["account_id"], name: "index_account_ssh_keys_on_account_id", using: :btree

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_otp_secret"
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.integer  "consumed_timestep"
    t.boolean  "otp_required_for_login"
    t.integer  "role",                      default: 1
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree

  create_table "accounts_host_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.integer  "host_id"
    t.integer  "host_user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "accounts_host_users", ["account_id"], name: "index_accounts_host_users_on_account_id", using: :btree
  add_index "accounts_host_users", ["host_id"], name: "index_accounts_host_users_on_host_id", using: :btree
  add_index "accounts_host_users", ["host_user_id"], name: "index_accounts_host_users_on_host_user_id", using: :btree

  create_table "bastion_hosts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "arch_mode",  default: 1
    t.string   "ip"
    t.string   "user"
    t.string   "desc"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "host_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "host_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "host_users", ["host_id"], name: "index_host_users_on_host_id", using: :btree

  create_table "hosts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "creator_account_id"
    t.string   "ip"
    t.string   "code"
    t.integer  "port"
    t.string   "comment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "hosts", ["creator_account_id"], name: "index_hosts_on_creator_account_id", unique: true, using: :btree

  add_foreign_key "account_ssh_keys", "accounts"
  add_foreign_key "accounts_host_users", "accounts"
  add_foreign_key "accounts_host_users", "host_users"
  add_foreign_key "accounts_host_users", "hosts"
  add_foreign_key "host_users", "hosts"
end
