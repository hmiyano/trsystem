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

ActiveRecord::Schema.define(version: 20180212105150) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "apprentices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_apprentices_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_apprentices_on_reset_password_token", unique: true, using: :btree
  end

  create_table "checklists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "section"
    t.string   "chapter"
    t.integer  "admin_id"
    t.boolean  "enable"
    t.boolean  "pg1ac",      default: false, null: false
    t.boolean  "pg1ak",      default: false, null: false
    t.string   "category"
    t.boolean  "pg1bc",      default: false, null: false
    t.boolean  "pg1bk",      default: false, null: false
    t.boolean  "pg2ac",      default: false, null: false
    t.boolean  "pg2ak",      default: false, null: false
    t.boolean  "pg2bc",      default: false, null: false
    t.boolean  "pg2bk",      default: false, null: false
    t.boolean  "pg2cc",      default: false, null: false
    t.boolean  "pg2ck",      default: false, null: false
    t.boolean  "pg3a",       default: false, null: false
    t.boolean  "pg3b",       default: false, null: false
    t.boolean  "pg3c",       default: false, null: false
    t.boolean  "g1a",        default: false, null: false
    t.boolean  "g1b",        default: false, null: false
    t.boolean  "g1c",        default: false, null: false
    t.boolean  "g1d",        default: false, null: false
    t.boolean  "g2a",        default: false, null: false
    t.boolean  "g2b",        default: false, null: false
    t.boolean  "g2c",        default: false, null: false
    t.boolean  "g2d",        default: false, null: false
    t.index ["admin_id"], name: "index_checklists_on_admin_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.integer  "trainee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "reply"
    t.integer  "trainer_id"
    t.index ["trainee_id"], name: "index_comments_on_trainee_id", using: :btree
    t.index ["trainer_id"], name: "index_comments_on_trainer_id", using: :btree
  end

  create_table "pg1ak_checklists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "admin_id"
    t.string   "chapter"
    t.string   "section"
    t.string   "content"
    t.boolean  "enable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_pg1ak_checklists_on_admin_id", using: :btree
  end

  create_table "te_checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "trainee_id"
    t.integer  "checklist_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "pg1ak_checklist_id"
    t.index ["checklist_id"], name: "index_te_checks_on_checklist_id", using: :btree
    t.index ["pg1ak_checklist_id"], name: "index_te_checks_on_pg1ak_checklist_id", using: :btree
    t.index ["trainee_id", "checklist_id", "type"], name: "index_te_checks_on_trainee_id_and_checklist_id_and_type", unique: true, using: :btree
    t.index ["trainee_id"], name: "index_te_checks_on_trainee_id", using: :btree
  end

  create_table "tr_checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "trainer_id"
    t.integer  "checklist_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "trainee_id"
    t.integer  "pg1ak_checklist_id"
    t.index ["checklist_id"], name: "index_tr_checks_on_checklist_id", using: :btree
    t.index ["pg1ak_checklist_id"], name: "index_tr_checks_on_pg1ak_checklist_id", using: :btree
    t.index ["trainee_id"], name: "index_tr_checks_on_trainee_id", using: :btree
    t.index ["trainer_id"], name: "index_tr_checks_on_trainer_id", using: :btree
  end

  create_table "trainees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "branch"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "nickname"
    t.integer  "trainer_id"
    t.boolean  "enable",          default: false, null: false
    t.string   "grade"
    t.boolean  "pg1ac",           default: false, null: false
    t.boolean  "pg1ak",           default: false, null: false
    t.boolean  "pg1bc",           default: false, null: false
    t.boolean  "pg1bk",           default: false, null: false
    t.boolean  "pg2ac",           default: false, null: false
    t.boolean  "pg2ak",           default: false, null: false
    t.boolean  "pg2bc",           default: false, null: false
    t.boolean  "pg2bk",           default: false, null: false
    t.boolean  "pg2cc",           default: false, null: false
    t.boolean  "pg2ck",           default: false, null: false
    t.boolean  "pg3a",            default: false, null: false
    t.boolean  "pg3b",            default: false, null: false
    t.boolean  "pg3c",            default: false, null: false
    t.boolean  "g1a",             default: false, null: false
    t.boolean  "g1b",             default: false, null: false
    t.boolean  "g1c",             default: false, null: false
    t.boolean  "g1d",             default: false, null: false
    t.boolean  "g2a",             default: false, null: false
    t.boolean  "g2b",             default: false, null: false
    t.boolean  "g2c",             default: false, null: false
    t.boolean  "g2d",             default: false, null: false
    t.string   "slack"
    t.index ["trainer_id"], name: "index_trainees_on_trainer_id", using: :btree
  end

  create_table "trainers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "branch"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "nickname"
    t.boolean  "enable"
    t.string   "grade"
    t.string   "slack"
  end

  add_foreign_key "checklists", "admins"
  add_foreign_key "comments", "trainees"
  add_foreign_key "comments", "trainers"
  add_foreign_key "pg1ak_checklists", "admins"
  add_foreign_key "te_checks", "checklists"
  add_foreign_key "te_checks", "pg1ak_checklists"
  add_foreign_key "te_checks", "trainees"
  add_foreign_key "tr_checks", "checklists"
  add_foreign_key "tr_checks", "pg1ak_checklists"
  add_foreign_key "tr_checks", "trainees"
  add_foreign_key "tr_checks", "trainers"
  add_foreign_key "trainees", "trainers"
end
