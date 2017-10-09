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

ActiveRecord::Schema.define(version: 20171009121550) do

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
    t.index ["checklist_id"], name: "index_tr_checks_on_checklist_id", using: :btree
    t.index ["trainer_id"], name: "index_tr_checks_on_trainer_id", using: :btree
  end

  create_table "trainees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "branch"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "trainers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "branch"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "te_checks", "checklists"
  add_foreign_key "te_checks", "trainees"
  add_foreign_key "tr_checks", "checklists"
  add_foreign_key "tr_checks", "trainers"
end
