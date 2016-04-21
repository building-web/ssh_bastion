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

ActiveRecord::Schema.define(version: 20160421143849) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                   default: "", null: false
    t.string   "encrypted_password",                      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.text     "encrypted_otp_secret",      limit: 65535
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.integer  "consumed_timestep"
    t.boolean  "otp_required_for_login"
    t.text     "otp_backup_codes",          limit: 65535
    t.integer  "role",                                    default: 1
    t.datetime "download_at"
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree

  create_table "assigned_hosts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.integer  "host_id"
    t.string   "mark"
    t.string   "user1"
    t.string   "user2"
    t.string   "user3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "assigned_hosts", ["account_id"], name: "index_assigned_hosts_on_account_id", using: :btree
  add_index "assigned_hosts", ["host_id"], name: "index_assigned_hosts_on_host_id", using: :btree

  create_table "bastion_hosts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "arch_mode",  default: 1
    t.string   "ip"
    t.string   "user"
    t.string   "desc"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "hosts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "creator_account_id"
    t.string   "ip"
    t.string   "code"
    t.integer  "port"
    t.string   "comment"
    t.string   "user1"
    t.string   "user2"
    t.string   "user3"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "hosts", ["creator_account_id"], name: "index_hosts_on_creator_account_id", using: :btree

  create_table "public_key_boxes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "public_key_boxable_type"
    t.integer  "public_key_boxable_id"
    t.string   "title"
    t.text     "key",                     limit: 65535
    t.string   "comment"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "public_key_boxes", ["public_key_boxable_type", "public_key_boxable_id"], name: "index_public_key_boxes_on_public_key_boxable", using: :btree

  add_foreign_key "assigned_hosts", "accounts"
  add_foreign_key "assigned_hosts", "hosts"
end
