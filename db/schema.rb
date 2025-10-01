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

ActiveRecord::Schema[8.0].define(version: 2025_10_01_040846) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "snippet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snippet_id"], name: "index_bookmarks_on_snippet_id"
    t.index ["user_id", "snippet_id"], name: "index_bookmarks_on_user_id_and_snippet_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "snippet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snippet_id"], name: "index_likes_on_snippet_id"
    t.index ["user_id", "snippet_id"], name: "index_likes_on_user_id_and_snippet_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "snippet_tags", force: :cascade do |t|
    t.integer "snippet_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snippet_id", "tag_id"], name: "index_snippet_tags_on_snippet_id_and_tag_id", unique: true
    t.index ["snippet_id"], name: "index_snippet_tags_on_snippet_id"
    t.index ["tag_id"], name: "index_snippet_tags_on_tag_id"
  end

  create_table "snippet_votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "snippet_id", null: false
    t.string "vote_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snippet_id"], name: "index_snippet_votes_on_snippet_id"
    t.index ["user_id"], name: "index_snippet_votes_on_user_id"
  end

  create_table "snippets", force: :cascade do |t|
    t.string "title"
    t.text "code"
    t.string "language"
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_snippets_on_user_id"
  end

  create_table "suggestion_votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "suggestion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vote_type", default: "implemented"
    t.index ["suggestion_id"], name: "index_suggestion_votes_on_suggestion_id"
    t.index ["user_id", "suggestion_id"], name: "index_suggestion_votes_on_user_id_and_suggestion_id", unique: true
    t.index ["user_id"], name: "index_suggestion_votes_on_user_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "snippet_id", null: false
    t.integer "response_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "suggestion_type", default: "feature_request"
    t.string "status", default: "pending"
    t.index ["snippet_id"], name: "index_suggestions_on_snippet_id"
    t.index ["user_id"], name: "index_suggestions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "admin"
    t.text "bio"
    t.string "favorite_languages"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "snippets"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "likes", "snippets"
  add_foreign_key "likes", "users"
  add_foreign_key "snippet_tags", "snippets"
  add_foreign_key "snippet_tags", "tags"
  add_foreign_key "snippet_votes", "snippets"
  add_foreign_key "snippet_votes", "users"
  add_foreign_key "snippets", "users"
  add_foreign_key "suggestion_votes", "suggestions"
  add_foreign_key "suggestion_votes", "users"
  add_foreign_key "suggestions", "snippets"
  add_foreign_key "suggestions", "users"
end
