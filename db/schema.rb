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

ActiveRecord::Schema.define(version: 20180809000001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_streams", id: :serial, force: :cascade do |t|
    t.integer "activity_stream_type_id", null: false
    t.integer "activity_stream_object_id", null: false
    t.integer "permission_id"
    t.integer "group_id"
    t.integer "o_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["activity_stream_object_id"], name: "index_activity_streams_on_activity_stream_object_id"
    t.index ["activity_stream_type_id"], name: "index_activity_streams_on_activity_stream_type_id"
    t.index ["created_at"], name: "index_activity_streams_on_created_at"
    t.index ["created_by_id"], name: "index_activity_streams_on_created_by_id"
    t.index ["group_id"], name: "index_activity_streams_on_group_id"
    t.index ["o_id"], name: "index_activity_streams_on_o_id"
    t.index ["permission_id"], name: "index_activity_streams_on_permission_id"
  end

  create_table "authorizations", id: :serial, force: :cascade do |t|
    t.string "provider", limit: 250, null: false
    t.string "uid", limit: 250, null: false
    t.string "token", limit: 2500
    t.string "secret", limit: 250
    t.string "username", limit: 250
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((username)::text)", name: "index_authorizations_on_username"
    t.index ["uid", "provider"], name: "index_authorizations_on_uid_and_provider"
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "avatars", id: :serial, force: :cascade do |t|
    t.integer "o_id", null: false
    t.integer "object_lookup_id", null: false
    t.boolean "default", default: false, null: false
    t.boolean "deletable", default: true, null: false
    t.boolean "initial", default: false, null: false
    t.integer "store_full_id"
    t.integer "store_resize_id"
    t.string "store_hash", limit: 32
    t.string "source", limit: 100, null: false
    t.string "source_url", limit: 512
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["default"], name: "index_avatars_on_default"
    t.index ["o_id", "object_lookup_id"], name: "index_avatars_on_o_id_and_object_lookup_id"
    t.index ["source"], name: "index_avatars_on_source"
    t.index ["store_hash"], name: "index_avatars_on_store_hash"
  end

  create_table "calendars", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250
    t.string "timezone", limit: 250
    t.string "business_hours", limit: 3000
    t.boolean "default", default: false, null: false
    t.string "ical_url", limit: 500
    t.text "public_holidays"
    t.text "last_log"
    t.datetime "last_sync", precision: 3
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_calendars_on_name", unique: true
  end

  create_table "channels", id: :serial, force: :cascade do |t|
    t.integer "group_id"
    t.string "area", limit: 100, null: false
    t.text "options"
    t.boolean "active", default: true, null: false
    t.string "preferences", limit: 2000
    t.text "last_log_in"
    t.text "last_log_out"
    t.string "status_in", limit: 100
    t.string "status_out", limit: 100
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["area"], name: "index_channels_on_area"
  end

  create_table "chat_agents", id: :serial, force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.integer "concurrent", default: 5, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["active"], name: "index_chat_agents_on_active"
    t.index ["created_by_id"], name: "index_chat_agents_on_created_by_id", unique: true
    t.index ["updated_by_id"], name: "index_chat_agents_on_updated_by_id", unique: true
  end

  create_table "chat_messages", id: :serial, force: :cascade do |t|
    t.integer "chat_session_id", null: false
    t.text "content", null: false
    t.integer "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["chat_session_id"], name: "index_chat_messages_on_chat_session_id"
  end

  create_table "chat_sessions", id: :serial, force: :cascade do |t|
    t.integer "chat_id", null: false
    t.string "session_id", null: false
    t.string "name", limit: 250
    t.string "state", limit: 50, default: "waiting", null: false
    t.integer "user_id"
    t.text "preferences"
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["chat_id"], name: "index_chat_sessions_on_chat_id"
    t.index ["session_id"], name: "index_chat_sessions_on_session_id"
    t.index ["state"], name: "index_chat_sessions_on_state"
    t.index ["user_id"], name: "index_chat_sessions_on_user_id"
  end

  create_table "chat_topics", id: :serial, force: :cascade do |t|
    t.integer "chat_id", null: false
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_chat_topics_on_name", unique: true
  end

  create_table "chats", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250
    t.integer "max_queue", default: 5, null: false
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.boolean "public", default: false, null: false
    t.string "block_ip", limit: 5000
    t.string "block_country", limit: 5000
    t.string "preferences", limit: 5000
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_chats_on_name", unique: true
  end

  create_table "cti_caller_ids", id: :serial, force: :cascade do |t|
    t.string "caller_id", limit: 100, null: false
    t.string "comment", limit: 500
    t.string "level", limit: 100, null: false
    t.string "object", limit: 100, null: false
    t.integer "o_id", null: false
    t.integer "user_id"
    t.text "preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["caller_id", "level"], name: "index_cti_caller_ids_on_caller_id_and_level"
    t.index ["caller_id", "user_id"], name: "index_cti_caller_ids_on_caller_id_and_user_id"
    t.index ["caller_id"], name: "index_cti_caller_ids_on_caller_id"
    t.index ["object", "o_id"], name: "index_cti_caller_ids_on_object_and_o_id"
  end

  create_table "cti_logs", id: :serial, force: :cascade do |t|
    t.string "direction", limit: 20, null: false
    t.string "state", limit: 20, null: false
    t.string "from", limit: 100, null: false
    t.string "from_comment", limit: 250
    t.string "to", limit: 100, null: false
    t.string "to_comment", limit: 250
    t.string "queue", limit: 250
    t.string "call_id", limit: 250, null: false
    t.string "comment", limit: 500
    t.datetime "initialized_at", precision: 3
    t.datetime "start_at", precision: 3
    t.datetime "end_at", precision: 3
    t.integer "duration_waiting_time"
    t.integer "duration_talking_time"
    t.boolean "done", default: true, null: false
    t.text "preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["call_id"], name: "index_cti_logs_on_call_id", unique: true
    t.index ["direction"], name: "index_cti_logs_on_direction"
    t.index ["from"], name: "index_cti_logs_on_from"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "email_addresses", id: :serial, force: :cascade do |t|
    t.integer "channel_id"
    t.string "realname", limit: 250, null: false
    t.string "email", limit: 250, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.string "preferences", limit: 2000
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["email"], name: "index_email_addresses_on_email", unique: true
  end

  create_table "external_credentials", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "credentials", limit: 2500, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "external_syncs", id: :serial, force: :cascade do |t|
    t.string "source", limit: 100, null: false
    t.string "source_id", limit: 200, null: false
    t.string "object", limit: 100, null: false
    t.integer "o_id", null: false
    t.text "last_payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["object", "o_id"], name: "index_external_syncs_on_object_and_o_id"
    t.index ["source", "source_id", "object", "o_id"], name: "index_external_syncs_on_source_and_source_id_and_object_o_id"
    t.index ["source", "source_id"], name: "index_external_syncs_on_source_and_source_id", unique: true
  end

  create_table "groups", id: :serial, force: :cascade do |t|
    t.integer "signature_id"
    t.integer "email_address_id"
    t.string "name", limit: 160, null: false
    t.integer "assignment_timeout"
    t.string "follow_up_possible", limit: 100, default: "yes", null: false
    t.boolean "follow_up_assignment", default: true, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_groups_on_name", unique: true
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.string "access", limit: 50, default: "full", null: false
    t.index ["access"], name: "index_groups_users_on_access"
    t.index ["group_id"], name: "index_groups_users_on_group_id"
    t.index ["user_id"], name: "index_groups_users_on_user_id"
  end

  create_table "histories", id: :serial, force: :cascade do |t|
    t.integer "history_type_id", null: false
    t.integer "history_object_id", null: false
    t.integer "history_attribute_id"
    t.integer "o_id", null: false
    t.integer "related_o_id"
    t.integer "related_history_object_id"
    t.integer "id_to"
    t.integer "id_from"
    t.string "value_from", limit: 500
    t.string "value_to", limit: 500
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_at"], name: "index_histories_on_created_at"
    t.index ["created_by_id"], name: "index_histories_on_created_by_id"
    t.index ["history_attribute_id"], name: "index_histories_on_history_attribute_id"
    t.index ["history_object_id"], name: "index_histories_on_history_object_id"
    t.index ["history_type_id"], name: "index_histories_on_history_type_id"
    t.index ["id_from"], name: "index_histories_on_id_from"
    t.index ["id_to"], name: "index_histories_on_id_to"
    t.index ["o_id"], name: "index_histories_on_o_id"
    t.index ["value_from"], name: "index_histories_on_value_from"
    t.index ["value_to"], name: "index_histories_on_value_to"
  end

  create_table "history_attributes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_history_attributes_on_name", unique: true
  end

  create_table "history_objects", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_history_objects_on_name", unique: true
  end

  create_table "history_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_history_types_on_name", unique: true
  end

  create_table "http_logs", id: :serial, force: :cascade do |t|
    t.string "direction", limit: 20, null: false
    t.string "facility", limit: 100, null: false
    t.string "method", limit: 100, null: false
    t.string "url", limit: 255, null: false
    t.string "status", limit: 20
    t.string "ip", limit: 50
    t.string "request", limit: 10000, null: false
    t.string "response", limit: 10000, null: false
    t.integer "updated_by_id"
    t.integer "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_at"], name: "index_http_logs_on_created_at"
    t.index ["created_by_id"], name: "index_http_logs_on_created_by_id"
    t.index ["facility"], name: "index_http_logs_on_facility"
  end

  create_table "import_jobs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.boolean "dry_run", default: false
    t.text "payload"
    t.text "result"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "timeplan", limit: 2500, null: false
    t.text "condition", null: false
    t.text "perform", null: false
    t.boolean "disable_notification", default: true, null: false
    t.datetime "last_run_at", precision: 3
    t.datetime "next_run_at", precision: 3
    t.boolean "running", default: false, null: false
    t.integer "processed", default: 0, null: false
    t.integer "matching", null: false
    t.string "pid", limit: 250
    t.string "note", limit: 250
    t.boolean "active", default: false, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_jobs_on_name", unique: true
  end

  create_table "karma_activities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 200, null: false
    t.string "description", limit: 200, null: false
    t.integer "score", null: false
    t.integer "once_ttl", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_karma_activities_on_name", unique: true
  end

  create_table "karma_activity_logs", id: :serial, force: :cascade do |t|
    t.integer "o_id", null: false
    t.integer "object_lookup_id", null: false
    t.integer "user_id", null: false
    t.integer "activity_id", null: false
    t.integer "score", null: false
    t.integer "score_total", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_at"], name: "index_karma_activity_logs_on_created_at"
    t.index ["o_id", "object_lookup_id"], name: "index_karma_activity_logs_on_o_id_and_object_lookup_id"
    t.index ["user_id"], name: "index_karma_activity_logs_on_user_id"
  end

  create_table "karma_users", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "score", null: false
    t.string "level", limit: 200, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["user_id"], name: "index_karma_users_on_user_id", unique: true
  end

  create_table "link_objects", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_link_objects_on_name", unique: true
  end

  create_table "link_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_link_types_on_name", unique: true
  end

  create_table "links", id: :serial, force: :cascade do |t|
    t.integer "link_type_id", null: false
    t.integer "link_object_source_id", null: false
    t.integer "link_object_source_value", null: false
    t.integer "link_object_target_id", null: false
    t.integer "link_object_target_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["link_object_source_id", "link_object_source_value", "link_object_target_id", "link_object_target_value", "link_type_id"], name: "links_uniq_total", unique: true
  end

  create_table "locales", id: :serial, force: :cascade do |t|
    t.string "locale", limit: 20, null: false
    t.string "alias", limit: 20
    t.string "name", limit: 255, null: false
    t.string "dir", limit: 9, default: "ltr", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((locale)::text)", name: "index_locales_on_locale", unique: true
    t.index "lower((name)::text)", name: "index_locales_on_name", unique: true
  end

  create_table "macros", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250
    t.text "perform", null: false
    t.boolean "active", default: true, null: false
    t.string "ux_flow_next_up", default: "none", null: false
    t.string "note", limit: 250
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_macros_on_name", unique: true
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.string "subject", limit: 250, null: false
    t.string "body", limit: 8000, null: false
    t.string "content_type", limit: 250, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "oauth_access_grants", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confidential", default: true, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "object_lookups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_object_lookups_on_name", unique: true
  end

  create_table "object_manager_attributes", id: :serial, force: :cascade do |t|
    t.integer "object_lookup_id", null: false
    t.string "name", limit: 200, null: false
    t.string "display", limit: 200, null: false
    t.string "data_type", limit: 100, null: false
    t.text "data_option"
    t.text "data_option_new"
    t.boolean "editable", default: true, null: false
    t.boolean "active", default: true, null: false
    t.string "screens", limit: 2000
    t.boolean "to_create", default: false, null: false
    t.boolean "to_migrate", default: false, null: false
    t.boolean "to_delete", default: false, null: false
    t.boolean "to_config", default: false, null: false
    t.integer "position", null: false
    t.integer "created_by_id", null: false
    t.integer "updated_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "object_lookup_id, lower((name)::text)", name: "index_object_manager_attributes_on_object_lookup_id_and_name", unique: true
    t.index ["object_lookup_id"], name: "index_object_manager_attributes_on_object_lookup_id"
  end

  create_table "online_notifications", id: :serial, force: :cascade do |t|
    t.integer "o_id", null: false
    t.integer "object_lookup_id", null: false
    t.integer "type_lookup_id", null: false
    t.integer "user_id", null: false
    t.boolean "seen", default: false, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_at"], name: "index_online_notifications_on_created_at"
    t.index ["seen"], name: "index_online_notifications_on_seen"
    t.index ["updated_at"], name: "index_online_notifications_on_updated_at"
    t.index ["user_id"], name: "index_online_notifications_on_user_id"
  end

  create_table "organizations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.boolean "shared", default: true, null: false
    t.string "domain", limit: 250, default: ""
    t.boolean "domain_assignment", default: false, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 5000, default: ""
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_organizations_on_name", unique: true
    t.index ["domain"], name: "index_organizations_on_domain"
  end

  create_table "organizations_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "organization_id"
    t.index ["organization_id"], name: "index_organizations_users_on_organization_id"
    t.index ["user_id"], name: "index_organizations_users_on_user_id"
  end

  create_table "overviews", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "link", limit: 250, null: false
    t.integer "prio", null: false
    t.text "condition", null: false
    t.string "order", limit: 2500, null: false
    t.string "group_by", limit: 250
    t.string "group_direction", limit: 250
    t.boolean "organization_shared", default: false, null: false
    t.boolean "out_of_office", default: false, null: false
    t.string "view", limit: 1000, null: false
    t.boolean "active", default: true, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_overviews_on_name"
  end

  create_table "overviews_groups", id: false, force: :cascade do |t|
    t.integer "overview_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_overviews_groups_on_group_id"
    t.index ["overview_id"], name: "index_overviews_groups_on_overview_id"
  end

  create_table "overviews_roles", id: false, force: :cascade do |t|
    t.integer "overview_id"
    t.integer "role_id"
    t.index ["overview_id"], name: "index_overviews_roles_on_overview_id"
    t.index ["role_id"], name: "index_overviews_roles_on_role_id"
  end

  create_table "overviews_users", id: false, force: :cascade do |t|
    t.integer "overview_id"
    t.integer "user_id"
    t.index ["overview_id"], name: "index_overviews_users_on_overview_id"
    t.index ["user_id"], name: "index_overviews_users_on_user_id"
  end

  create_table "package_migrations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "version", limit: 250, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "packages", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "version", limit: 50, null: false
    t.string "vendor", limit: 150, null: false
    t.string "state", limit: 50, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "permissions", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "note", limit: 500
    t.string "preferences", limit: 10000
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_permissions_on_name", unique: true
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
    t.index ["permission_id"], name: "index_permissions_roles_on_permission_id"
    t.index ["role_id"], name: "index_permissions_roles_on_role_id"
  end

  create_table "postmaster_filters", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "channel", limit: 250, null: false
    t.text "match", null: false
    t.text "perform", null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["channel"], name: "index_postmaster_filters_on_channel"
  end

  create_table "recent_views", id: :serial, force: :cascade do |t|
    t.integer "recent_view_object_id", null: false
    t.integer "o_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_at"], name: "index_recent_views_on_created_at"
    t.index ["created_by_id"], name: "index_recent_views_on_created_by_id"
    t.index ["o_id"], name: "index_recent_views_on_o_id"
    t.index ["recent_view_object_id"], name: "index_recent_views_on_recent_view_object_id"
  end

  create_table "report_profiles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 150
    t.text "condition"
    t.boolean "active", default: true, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_report_profiles_on_name", unique: true
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "preferences"
    t.boolean "default_at_signup", default: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_roles_on_name", unique: true
  end

  create_table "roles_groups", id: false, force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "group_id", null: false
    t.string "access", limit: 50, default: "full", null: false
    t.index ["access"], name: "index_roles_groups_on_access"
    t.index ["group_id"], name: "index_roles_groups_on_group_id"
    t.index ["role_id"], name: "index_roles_groups_on_role_id"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "schedulers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "method", limit: 250, null: false
    t.integer "period"
    t.integer "running", default: 0, null: false
    t.datetime "last_run", precision: 3
    t.integer "prio", null: false
    t.string "pid", limit: 250
    t.string "note", limit: 250
    t.string "error_message"
    t.string "status"
    t.boolean "active", default: false, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_schedulers_on_name", unique: true
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", null: false
    t.boolean "persistent"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["persistent"], name: "index_sessions_on_persistent"
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.string "name", limit: 200, null: false
    t.string "area", limit: 100, null: false
    t.string "description", limit: 2000, null: false
    t.string "options", limit: 2000
    t.text "state_current"
    t.string "state_initial", limit: 2000
    t.boolean "frontend", null: false
    t.text "preferences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_settings_on_name", unique: true
    t.index ["area"], name: "index_settings_on_area"
    t.index ["frontend"], name: "index_settings_on_frontend"
  end

  create_table "signatures", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "body"
    t.boolean "active", default: true, null: false
    t.string "note", limit: 250
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_signatures_on_name", unique: true
  end

  create_table "slas", id: :serial, force: :cascade do |t|
    t.integer "calendar_id", null: false
    t.string "name", limit: 150
    t.integer "first_response_time"
    t.integer "update_time"
    t.integer "solution_time"
    t.text "condition"
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_slas_on_name", unique: true
  end

  create_table "stats_stores", id: :serial, force: :cascade do |t|
    t.integer "stats_store_object_id", null: false
    t.integer "o_id", null: false
    t.string "key", limit: 250
    t.integer "related_o_id"
    t.integer "related_stats_store_object_id"
    t.string "data", limit: 5000
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_at"], name: "index_stats_stores_on_created_at"
    t.index ["created_by_id"], name: "index_stats_stores_on_created_by_id"
    t.index ["key"], name: "index_stats_stores_on_key"
    t.index ["o_id"], name: "index_stats_stores_on_o_id"
    t.index ["stats_store_object_id"], name: "index_stats_stores_on_stats_store_object_id"
  end

  create_table "store_files", id: :serial, force: :cascade do |t|
    t.string "sha", limit: 128, null: false
    t.string "provider", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["provider"], name: "index_store_files_on_provider"
    t.index ["sha"], name: "index_store_files_on_sha", unique: true
  end

  create_table "store_objects", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_store_objects_on_name", unique: true
  end

  create_table "store_provider_dbs", id: :serial, force: :cascade do |t|
    t.string "sha", limit: 128, null: false
    t.binary "data"
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["sha"], name: "index_store_provider_dbs_on_sha", unique: true
  end

  create_table "stores", id: :serial, force: :cascade do |t|
    t.integer "store_object_id", null: false
    t.integer "store_file_id", null: false
    t.bigint "o_id", null: false
    t.string "preferences", limit: 2500
    t.string "size", limit: 50
    t.string "filename", limit: 250, null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["store_object_id", "o_id"], name: "index_stores_on_store_object_id_and_o_id"
  end

  create_table "tag_items", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "name_downcase", limit: 250, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["name_downcase"], name: "index_tag_items_on_name_downcase"
  end

  create_table "tag_objects", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_tag_objects_on_name", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.integer "tag_item_id", null: false
    t.integer "tag_object_id", null: false
    t.integer "o_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["o_id"], name: "index_tags_on_o_id"
    t.index ["tag_object_id"], name: "index_tags_on_tag_object_id"
  end

  create_table "taskbars", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "last_contact", null: false
    t.string "client_id", null: false
    t.string "key", limit: 100, null: false
    t.string "callback", limit: 100, null: false
    t.text "state"
    t.text "preferences"
    t.string "params", limit: 2000
    t.integer "prio", null: false
    t.boolean "notify", default: false, null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["client_id"], name: "index_taskbars_on_client_id"
    t.index ["key"], name: "index_taskbars_on_key"
    t.index ["user_id"], name: "index_taskbars_on_user_id"
  end

  create_table "templates", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name", limit: 250, null: false
    t.text "options", null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_templates_on_name"
    t.index ["user_id"], name: "index_templates_on_user_id"
  end

  create_table "templates_groups", id: false, force: :cascade do |t|
    t.integer "template_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_templates_groups_on_group_id"
    t.index ["template_id"], name: "index_templates_groups_on_template_id"
  end

  create_table "text_modules", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name", limit: 250, null: false
    t.string "keywords", limit: 500
    t.text "content", null: false
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.integer "foreign_id"
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_text_modules_on_name"
    t.index ["user_id"], name: "index_text_modules_on_user_id"
  end

  create_table "text_modules_groups", id: false, force: :cascade do |t|
    t.integer "text_module_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_text_modules_groups_on_group_id"
    t.index ["text_module_id"], name: "index_text_modules_groups_on_text_module_id"
  end

  create_table "ticket_article_flags", id: :serial, force: :cascade do |t|
    t.integer "ticket_article_id", null: false
    t.string "key", limit: 50, null: false
    t.string "value", limit: 50
    t.integer "created_by_id", null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_by_id"], name: "index_ticket_article_flags_on_created_by_id"
    t.index ["ticket_article_id", "created_by_id"], name: "index_ticket_article_flags_on_articles_id_and_created_by_id"
    t.index ["ticket_article_id", "key"], name: "index_ticket_article_flags_on_ticket_article_id_and_key"
    t.index ["ticket_article_id"], name: "index_ticket_article_flags_on_ticket_article_id"
  end

  create_table "ticket_article_senders", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_ticket_article_senders_on_name", unique: true
  end

  create_table "ticket_article_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.boolean "communication", null: false
    t.boolean "active", default: true, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_ticket_article_types_on_name", unique: true
  end

  create_table "ticket_articles", id: :serial, force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.integer "type_id", null: false
    t.integer "sender_id", null: false
    t.string "from", limit: 3000
    t.string "to", limit: 3000
    t.string "cc", limit: 3000
    t.string "subject", limit: 3000
    t.string "reply_to", limit: 300
    t.string "message_id", limit: 3000
    t.string "message_id_md5", limit: 32
    t.string "in_reply_to", limit: 3000
    t.string "content_type", limit: 20, default: "text/plain", null: false
    t.string "references", limit: 3200
    t.text "body", null: false
    t.boolean "internal", default: false, null: false
    t.text "preferences"
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.integer "origin_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_at"], name: "index_ticket_articles_on_created_at"
    t.index ["created_by_id"], name: "index_ticket_articles_on_created_by_id"
    t.index ["internal"], name: "index_ticket_articles_on_internal"
    t.index ["message_id_md5", "type_id"], name: "index_ticket_articles_message_id_md5_type_id"
    t.index ["message_id_md5"], name: "index_ticket_articles_on_message_id_md5"
    t.index ["sender_id"], name: "index_ticket_articles_on_sender_id"
    t.index ["ticket_id"], name: "index_ticket_articles_on_ticket_id"
    t.index ["type_id"], name: "index_ticket_articles_on_type_id"
  end

  create_table "ticket_counters", id: :serial, force: :cascade do |t|
    t.string "content", limit: 100, null: false
    t.string "generator", limit: 100, null: false
    t.index ["generator"], name: "index_ticket_counters_on_generator", unique: true
  end

  create_table "ticket_flags", id: :serial, force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.string "key", limit: 50, null: false
    t.string "value", limit: 50
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_by_id"], name: "index_ticket_flags_on_created_by_id"
    t.index ["ticket_id", "created_by_id"], name: "index_ticket_flags_on_ticket_id_and_created_by_id"
    t.index ["ticket_id", "key"], name: "index_ticket_flags_on_ticket_id_and_key"
    t.index ["ticket_id"], name: "index_ticket_flags_on_ticket_id"
  end

  create_table "ticket_priorities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.boolean "default_create", default: false, null: false
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_ticket_priorities_on_name", unique: true
    t.index ["default_create"], name: "index_ticket_priorities_on_default_create"
  end

  create_table "ticket_state_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.string "note", limit: 250
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_ticket_state_types_on_name", unique: true
  end

  create_table "ticket_states", id: :serial, force: :cascade do |t|
    t.integer "state_type_id", null: false
    t.string "name", limit: 250, null: false
    t.integer "next_state_id"
    t.boolean "ignore_escalation", default: false, null: false
    t.boolean "default_create", default: false, null: false
    t.boolean "default_follow_up", default: false, null: false
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_ticket_states_on_name", unique: true
    t.index ["default_create"], name: "index_ticket_states_on_default_create"
    t.index ["default_follow_up"], name: "index_ticket_states_on_default_follow_up"
  end

  create_table "ticket_time_accountings", id: :serial, force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.integer "ticket_article_id"
    t.decimal "time_unit", precision: 6, scale: 2, null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_by_id"], name: "index_ticket_time_accountings_on_created_by_id"
    t.index ["ticket_article_id"], name: "index_ticket_time_accountings_on_ticket_article_id"
    t.index ["ticket_id"], name: "index_ticket_time_accountings_on_ticket_id"
    t.index ["time_unit"], name: "index_ticket_time_accountings_on_time_unit"
  end

  create_table "tickets", id: :serial, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "priority_id", null: false
    t.integer "state_id", null: false
    t.integer "organization_id"
    t.string "number", limit: 60, null: false
    t.string "title", limit: 250, null: false
    t.integer "owner_id", null: false
    t.integer "customer_id", null: false
    t.string "note", limit: 250
    t.datetime "first_response_at", precision: 3
    t.datetime "first_response_escalation_at", precision: 3
    t.integer "first_response_in_min"
    t.integer "first_response_diff_in_min"
    t.datetime "close_at", precision: 3
    t.datetime "close_escalation_at", precision: 3
    t.integer "close_in_min"
    t.integer "close_diff_in_min"
    t.datetime "update_escalation_at", precision: 3
    t.integer "update_in_min"
    t.integer "update_diff_in_min"
    t.datetime "last_contact_at", precision: 3
    t.datetime "last_contact_agent_at", precision: 3
    t.datetime "last_contact_customer_at", precision: 3
    t.datetime "last_owner_update_at", precision: 3
    t.integer "create_article_type_id"
    t.integer "create_article_sender_id"
    t.integer "article_count"
    t.datetime "escalation_at", precision: 3
    t.datetime "pending_time", precision: 3
    t.string "type", limit: 100
    t.decimal "time_unit", precision: 6, scale: 2
    t.text "preferences"
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["close_at"], name: "index_tickets_on_close_at"
    t.index ["close_diff_in_min"], name: "index_tickets_on_close_diff_in_min"
    t.index ["close_escalation_at"], name: "index_tickets_on_close_escalation_at"
    t.index ["close_in_min"], name: "index_tickets_on_close_in_min"
    t.index ["create_article_sender_id"], name: "index_tickets_on_create_article_sender_id"
    t.index ["create_article_type_id"], name: "index_tickets_on_create_article_type_id"
    t.index ["created_at"], name: "index_tickets_on_created_at"
    t.index ["created_by_id"], name: "index_tickets_on_created_by_id"
    t.index ["customer_id"], name: "index_tickets_on_customer_id"
    t.index ["escalation_at"], name: "index_tickets_on_escalation_at"
    t.index ["first_response_at"], name: "index_tickets_on_first_response_at"
    t.index ["first_response_diff_in_min"], name: "index_tickets_on_first_response_diff_in_min"
    t.index ["first_response_escalation_at"], name: "index_tickets_on_first_response_escalation_at"
    t.index ["first_response_in_min"], name: "index_tickets_on_first_response_in_min"
    t.index ["group_id"], name: "index_tickets_on_group_id"
    t.index ["last_contact_agent_at"], name: "index_tickets_on_last_contact_agent_at"
    t.index ["last_contact_at"], name: "index_tickets_on_last_contact_at"
    t.index ["last_contact_customer_at"], name: "index_tickets_on_last_contact_customer_at"
    t.index ["last_owner_update_at"], name: "index_tickets_on_last_owner_update_at"
    t.index ["number"], name: "index_tickets_on_number", unique: true
    t.index ["owner_id"], name: "index_tickets_on_owner_id"
    t.index ["pending_time"], name: "index_tickets_on_pending_time"
    t.index ["priority_id"], name: "index_tickets_on_priority_id"
    t.index ["state_id"], name: "index_tickets_on_state_id"
    t.index ["time_unit"], name: "index_tickets_on_time_unit"
    t.index ["title"], name: "index_tickets_on_title"
    t.index ["type"], name: "index_tickets_on_type"
    t.index ["update_diff_in_min"], name: "index_tickets_on_update_diff_in_min"
    t.index ["update_in_min"], name: "index_tickets_on_update_in_min"
  end

  create_table "tokens", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "persistent"
    t.string "name", limit: 100, null: false
    t.string "action", limit: 40, null: false
    t.string "label", limit: 255
    t.text "preferences"
    t.datetime "last_used_at", precision: 3
    t.date "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text), action", name: "index_tokens_on_name_and_action", unique: true
    t.index ["created_at"], name: "index_tokens_on_created_at"
    t.index ["persistent"], name: "index_tokens_on_persistent"
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "translations", id: :serial, force: :cascade do |t|
    t.string "locale", limit: 10, null: false
    t.string "source", limit: 500, null: false
    t.string "target", limit: 500, null: false
    t.string "target_initial", limit: 500, null: false
    t.string "format", limit: 20, default: "string", null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((locale)::text)", name: "index_translations_on_locale"
    t.index ["source"], name: "index_translations_on_source"
  end

  create_table "triggers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.text "condition", null: false
    t.text "perform", null: false
    t.boolean "disable_notification", default: true, null: false
    t.string "note", limit: 250
    t.boolean "active", default: true, null: false
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_triggers_on_name", unique: true
  end

  create_table "type_lookups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 250, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((name)::text)", name: "index_type_lookups_on_name", unique: true
  end

  create_table "user_devices", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", limit: 250, null: false
    t.string "os", limit: 150
    t.string "browser", limit: 250
    t.string "location", limit: 150
    t.string "device_details", limit: 2500
    t.string "location_details", limit: 2500
    t.string "fingerprint", limit: 160
    t.string "user_agent", limit: 250
    t.string "ip", limit: 160
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["created_at"], name: "index_user_devices_on_created_at"
    t.index ["fingerprint"], name: "index_user_devices_on_fingerprint"
    t.index ["os", "browser", "location"], name: "index_user_devices_on_os_and_browser_and_location"
    t.index ["updated_at"], name: "index_user_devices_on_updated_at"
    t.index ["user_id"], name: "index_user_devices_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.integer "organization_id"
    t.string "login", limit: 255, null: false
    t.string "firstname", limit: 100, default: ""
    t.string "lastname", limit: 100, default: ""
    t.string "email", limit: 255, default: ""
    t.string "image", limit: 100
    t.string "image_source", limit: 200
    t.string "web", limit: 100, default: ""
    t.string "password", limit: 100
    t.string "phone", limit: 100, default: ""
    t.string "fax", limit: 100, default: ""
    t.string "mobile", limit: 100, default: ""
    t.string "department", limit: 200, default: ""
    t.string "street", limit: 120, default: ""
    t.string "zip", limit: 100, default: ""
    t.string "city", limit: 100, default: ""
    t.string "country", limit: 100, default: ""
    t.string "address", limit: 500, default: ""
    t.boolean "vip", default: false
    t.boolean "verified", default: false, null: false
    t.boolean "active", default: true, null: false
    t.string "note", limit: 5000, default: ""
    t.datetime "last_login", precision: 3
    t.string "source", limit: 200
    t.integer "login_failed", default: 0, null: false
    t.boolean "out_of_office", default: false, null: false
    t.date "out_of_office_start_at"
    t.date "out_of_office_end_at"
    t.integer "out_of_office_replacement_id"
    t.string "preferences", limit: 8000
    t.integer "updated_by_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index "lower((login)::text)", name: "index_users_on_login", unique: true
    t.index ["created_by_id"], name: "index_users_on_created_by_id"
    t.index ["department"], name: "index_users_on_department"
    t.index ["email"], name: "index_users_on_email"
    t.index ["fax"], name: "index_users_on_fax"
    t.index ["image"], name: "index_users_on_image"
    t.index ["mobile"], name: "index_users_on_mobile"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["out_of_office", "out_of_office_start_at", "out_of_office_end_at"], name: "index_out_of_office"
    t.index ["out_of_office_replacement_id"], name: "index_users_on_out_of_office_replacement_id"
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["source"], name: "index_users_on_source"
  end

  add_foreign_key "activity_streams", "groups"
  add_foreign_key "activity_streams", "object_lookups", column: "activity_stream_object_id"
  add_foreign_key "activity_streams", "permissions"
  add_foreign_key "activity_streams", "type_lookups", column: "activity_stream_type_id"
  add_foreign_key "activity_streams", "users", column: "created_by_id"
  add_foreign_key "authorizations", "users"
  add_foreign_key "avatars", "users", column: "created_by_id"
  add_foreign_key "avatars", "users", column: "updated_by_id"
  add_foreign_key "calendars", "users", column: "created_by_id"
  add_foreign_key "calendars", "users", column: "updated_by_id"
  add_foreign_key "channels", "groups"
  add_foreign_key "channels", "users", column: "created_by_id"
  add_foreign_key "channels", "users", column: "updated_by_id"
  add_foreign_key "chat_agents", "users", column: "created_by_id"
  add_foreign_key "chat_agents", "users", column: "updated_by_id"
  add_foreign_key "chat_messages", "chat_sessions"
  add_foreign_key "chat_messages", "users", column: "created_by_id"
  add_foreign_key "chat_sessions", "chats"
  add_foreign_key "chat_sessions", "users"
  add_foreign_key "chat_sessions", "users", column: "created_by_id"
  add_foreign_key "chat_sessions", "users", column: "updated_by_id"
  add_foreign_key "chat_topics", "users", column: "created_by_id"
  add_foreign_key "chat_topics", "users", column: "updated_by_id"
  add_foreign_key "chats", "users", column: "created_by_id"
  add_foreign_key "chats", "users", column: "updated_by_id"
  add_foreign_key "cti_caller_ids", "users"
  add_foreign_key "email_addresses", "users", column: "created_by_id"
  add_foreign_key "email_addresses", "users", column: "updated_by_id"
  add_foreign_key "groups", "email_addresses"
  add_foreign_key "groups", "signatures"
  add_foreign_key "groups", "users", column: "created_by_id"
  add_foreign_key "groups", "users", column: "updated_by_id"
  add_foreign_key "groups_users", "groups"
  add_foreign_key "groups_users", "users"
  add_foreign_key "histories", "history_attributes"
  add_foreign_key "histories", "history_objects"
  add_foreign_key "histories", "history_types"
  add_foreign_key "histories", "users", column: "created_by_id"
  add_foreign_key "http_logs", "users", column: "created_by_id"
  add_foreign_key "http_logs", "users", column: "updated_by_id"
  add_foreign_key "jobs", "users", column: "created_by_id"
  add_foreign_key "jobs", "users", column: "updated_by_id"
  add_foreign_key "karma_activity_logs", "karma_activities", column: "activity_id"
  add_foreign_key "karma_activity_logs", "users"
  add_foreign_key "karma_users", "users"
  add_foreign_key "links", "link_types"
  add_foreign_key "macros", "users", column: "created_by_id"
  add_foreign_key "macros", "users", column: "updated_by_id"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "object_manager_attributes", "object_lookups"
  add_foreign_key "object_manager_attributes", "users", column: "created_by_id"
  add_foreign_key "object_manager_attributes", "users", column: "updated_by_id"
  add_foreign_key "online_notifications", "users"
  add_foreign_key "online_notifications", "users", column: "created_by_id"
  add_foreign_key "online_notifications", "users", column: "updated_by_id"
  add_foreign_key "organizations", "users", column: "created_by_id"
  add_foreign_key "organizations", "users", column: "updated_by_id"
  add_foreign_key "organizations_users", "organizations"
  add_foreign_key "organizations_users", "users"
  add_foreign_key "overviews", "users", column: "created_by_id"
  add_foreign_key "overviews", "users", column: "updated_by_id"
  add_foreign_key "overviews_groups", "groups"
  add_foreign_key "overviews_groups", "overviews"
  add_foreign_key "overviews_roles", "overviews"
  add_foreign_key "overviews_roles", "roles"
  add_foreign_key "overviews_users", "overviews"
  add_foreign_key "overviews_users", "users"
  add_foreign_key "packages", "users", column: "created_by_id"
  add_foreign_key "packages", "users", column: "updated_by_id"
  add_foreign_key "postmaster_filters", "users", column: "created_by_id"
  add_foreign_key "postmaster_filters", "users", column: "updated_by_id"
  add_foreign_key "recent_views", "object_lookups", column: "recent_view_object_id"
  add_foreign_key "recent_views", "users", column: "created_by_id"
  add_foreign_key "report_profiles", "users", column: "created_by_id"
  add_foreign_key "report_profiles", "users", column: "updated_by_id"
  add_foreign_key "roles", "users", column: "created_by_id"
  add_foreign_key "roles", "users", column: "updated_by_id"
  add_foreign_key "roles_groups", "groups"
  add_foreign_key "roles_groups", "roles"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "schedulers", "users", column: "created_by_id"
  add_foreign_key "schedulers", "users", column: "updated_by_id"
  add_foreign_key "signatures", "users", column: "created_by_id"
  add_foreign_key "signatures", "users", column: "updated_by_id"
  add_foreign_key "slas", "users", column: "created_by_id"
  add_foreign_key "slas", "users", column: "updated_by_id"
  add_foreign_key "stats_stores", "users", column: "created_by_id"
  add_foreign_key "stores", "store_files"
  add_foreign_key "stores", "store_objects"
  add_foreign_key "stores", "users", column: "created_by_id"
  add_foreign_key "tags", "tag_items"
  add_foreign_key "tags", "tag_objects"
  add_foreign_key "tags", "users", column: "created_by_id"
  add_foreign_key "taskbars", "users"
  add_foreign_key "templates", "users"
  add_foreign_key "templates", "users", column: "created_by_id"
  add_foreign_key "templates", "users", column: "updated_by_id"
  add_foreign_key "templates_groups", "groups"
  add_foreign_key "templates_groups", "templates"
  add_foreign_key "text_modules", "users"
  add_foreign_key "text_modules", "users", column: "created_by_id"
  add_foreign_key "text_modules", "users", column: "updated_by_id"
  add_foreign_key "text_modules_groups", "groups"
  add_foreign_key "text_modules_groups", "text_modules"
  add_foreign_key "ticket_article_flags", "ticket_articles"
  add_foreign_key "ticket_article_flags", "users", column: "created_by_id"
  add_foreign_key "ticket_article_senders", "users", column: "created_by_id"
  add_foreign_key "ticket_article_senders", "users", column: "updated_by_id"
  add_foreign_key "ticket_article_types", "users", column: "created_by_id"
  add_foreign_key "ticket_article_types", "users", column: "updated_by_id"
  add_foreign_key "ticket_articles", "ticket_article_senders", column: "sender_id"
  add_foreign_key "ticket_articles", "ticket_article_types", column: "type_id"
  add_foreign_key "ticket_articles", "tickets"
  add_foreign_key "ticket_articles", "users", column: "created_by_id"
  add_foreign_key "ticket_articles", "users", column: "origin_by_id"
  add_foreign_key "ticket_articles", "users", column: "updated_by_id"
  add_foreign_key "ticket_flags", "tickets"
  add_foreign_key "ticket_flags", "users", column: "created_by_id"
  add_foreign_key "ticket_priorities", "users", column: "created_by_id"
  add_foreign_key "ticket_priorities", "users", column: "updated_by_id"
  add_foreign_key "ticket_state_types", "users", column: "created_by_id"
  add_foreign_key "ticket_state_types", "users", column: "updated_by_id"
  add_foreign_key "ticket_states", "ticket_state_types", column: "state_type_id"
  add_foreign_key "ticket_states", "users", column: "created_by_id"
  add_foreign_key "ticket_states", "users", column: "updated_by_id"
  add_foreign_key "ticket_time_accountings", "ticket_articles"
  add_foreign_key "ticket_time_accountings", "tickets"
  add_foreign_key "ticket_time_accountings", "users", column: "created_by_id"
  add_foreign_key "tickets", "groups"
  add_foreign_key "tickets", "organizations"
  add_foreign_key "tickets", "ticket_priorities", column: "priority_id"
  add_foreign_key "tickets", "ticket_states", column: "state_id"
  add_foreign_key "tickets", "users", column: "created_by_id"
  add_foreign_key "tickets", "users", column: "customer_id"
  add_foreign_key "tickets", "users", column: "owner_id"
  add_foreign_key "tickets", "users", column: "updated_by_id"
  add_foreign_key "tokens", "users"
  add_foreign_key "translations", "users", column: "created_by_id"
  add_foreign_key "translations", "users", column: "updated_by_id"
  add_foreign_key "triggers", "users", column: "created_by_id"
  add_foreign_key "triggers", "users", column: "updated_by_id"
  add_foreign_key "user_devices", "users"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "users", column: "created_by_id"
  add_foreign_key "users", "users", column: "out_of_office_replacement_id"
  add_foreign_key "users", "users", column: "updated_by_id"
end
