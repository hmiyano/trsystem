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

ActiveRecord::Schema.define(version: 20171016150248) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "checklists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "grade"
    t.string   "section"
    t.string   "chapter"
    t.integer  "admin_id"
    t.index ["admin_id"], name: "index_checklists_on_admin_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.integer  "trainee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trainee_id"], name: "index_comments_on_trainee_id", using: :btree
  end

  create_table "te_checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "trainee_id"
    t.integer  "checklist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["checklist_id"], name: "index_te_checks_on_checklist_id", using: :btree
    t.index ["trainee_id", "checklist_id", "type"], name: "index_te_checks_on_trainee_id_and_checklist_id_and_type", unique: true, using: :btree
    t.index ["trainee_id"], name: "index_te_checks_on_trainee_id", using: :btree
  end

  create_table "tr_checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "trainer_id"
    t.integer  "checklist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "trainee_id"
    t.index ["checklist_id"], name: "index_tr_checks_on_checklist_id", using: :btree
    t.index ["trainee_id"], name: "index_tr_checks_on_trainee_id", using: :btree
    t.index ["trainer_id"], name: "index_tr_checks_on_trainer_id", using: :btree
  end

  create_table "trainees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "branch"
    t.string   "password_digest"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "nickname"
    t.integer  "trainer_id"
    t.boolean  "enable",                 default: false, null: false
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
  end

  add_foreign_key "checklists", "admins"
  add_foreign_key "comments", "trainees"
  add_foreign_key "te_checks", "checklists"
  add_foreign_key "te_checks", "trainees"
  add_foreign_key "tr_checks", "checklists"
  add_foreign_key "tr_checks", "trainees"
  add_foreign_key "tr_checks", "trainers"
  add_foreign_key "trainees", "trainers"
end
