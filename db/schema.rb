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

ActiveRecord::Schema.define(version: 20170719143809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "poll_accesses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "poll_id"
    t.bigint "user_id"
    t.index ["poll_id"], name: "index_poll_accesses_on_poll_id"
    t.index ["user_id"], name: "index_poll_accesses_on_user_id"
  end

  create_table "poll_question_answers", force: :cascade do |t|
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id"
    t.index ["question_id"], name: "index_poll_question_answers_on_question_id"
  end

  create_table "poll_questions", force: :cascade do |t|
    t.string "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "poll_id"
    t.index ["poll_id"], name: "index_poll_questions_on_poll_id"
  end

  create_table "poll_results", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "poll_id"
    t.bigint "user_id"
    t.bigint "question_id"
    t.bigint "answer_id"
    t.index ["answer_id"], name: "index_poll_results_on_answer_id"
    t.index ["poll_id"], name: "index_poll_results_on_poll_id"
    t.index ["question_id"], name: "index_poll_results_on_question_id"
    t.index ["user_id"], name: "index_poll_results_on_user_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.string "key"
    t.index ["author_id"], name: "index_polls_on_author_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "poll_accesses", "polls"
  add_foreign_key "poll_accesses", "users"
  add_foreign_key "poll_question_answers", "poll_questions", column: "question_id"
  add_foreign_key "poll_questions", "polls"
  add_foreign_key "poll_results", "poll_question_answers", column: "answer_id"
  add_foreign_key "poll_results", "poll_questions", column: "question_id"
  add_foreign_key "poll_results", "polls"
  add_foreign_key "poll_results", "users"
  add_foreign_key "polls", "users", column: "author_id"
end
