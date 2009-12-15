# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091214231918) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audits", :force => true do |t|
    t.string   "auditable_type"
    t.integer  "auditable_id"
    t.string   "action"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "audits", ["auditable_type", "action"], :name => "auditable_index"
  add_index "audits", ["auditable_type", "auditable_id"], :name => "auditable_object"
  add_index "audits", ["user_id", "auditable_type"], :name => "auditable_user_index"
  add_index "audits", ["user_id"], :name => "index_audits_on_user_id"

  create_table "behavior_configs", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "behavior_configs", ["key"], :name => "index_behavior_configs_on_key"

  create_table "bookings", :force => true do |t|
    t.integer  "provider_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "code_samples", :force => true do |t|
    t.string   "name"
    t.text     "code"
    t.integer  "provider_id"
    t.string   "aasm_state"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reek_result"
    t.integer  "flay_result"
    t.decimal  "flog_result",    :precision => 8, :scale => 2
    t.integer  "roodi_result"
    t.decimal  "saikuro_result", :precision => 8, :scale => 2
  end

  create_table "endorsement_requests", :force => true do |t|
    t.integer  "provider_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "recipients"
  end

  create_table "endorsements", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.string   "email"
    t.string   "url"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "year_hired"
    t.string   "position"
    t.text     "endorsement"
    t.string   "aasm_state"
    t.integer  "sort_order"
    t.integer  "endorser_id"
  end

  add_index "endorsements", ["aasm_state"], :name => "index_recommendations_on_aasm_state"

  create_table "endorsers", :force => true do |t|
    t.integer "endorsement_request_id"
    t.string  "email"
    t.string  "validation_token"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company"
    t.string   "position"
    t.string   "year_hired"
    t.string   "project"
    t.text     "message"
    t.string   "aasm_state"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homepages", :force => true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "keywords"
    t.text     "description"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "portfolio_items", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.string   "year_completed"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provided_services", :force => true do |t|
    t.integer  "service_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proficiency"
  end

  create_table "providers", :force => true do |t|
    t.string   "company_name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state_province"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone_number"
    t.string   "email"
    t.integer  "company_size"
    t.string   "logo_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "hourly_rate",            :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "min_budget",             :precision => 10, :scale => 2, :default => 0.0
    t.string   "aasm_state"
    t.string   "further_street_address"
    t.integer  "user_id"
    t.string   "slug"
    t.string   "company_url"
    t.text     "marketing_description"
    t.integer  "endorsements_count",                                    :default => 0
    t.integer  "min_hours"
    t.integer  "max_hours"
    t.integer  "min_project_length"
    t.integer  "max_project_length"
  end

  add_index "providers", ["slug"], :name => "index_providers_on_slug"

  create_table "questions", :force => true do |t|
    t.integer  "quiz_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_result_answers", :force => true do |t|
    t.integer  "quiz_result_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_results", :force => true do |t|
    t.integer  "provider_id"
    t.integer  "quiz_id"
    t.boolean  "passed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reference_requests", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "validation_token"
    t.integer  "endorsement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "references", :force => true do |t|
    t.text     "message"
    t.integer  "reference_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requested_services", :force => true do |t|
    t.integer  "rfp_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "rfp_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "unread",      :default => true
  end

  add_index "requests", ["provider_id"], :name => "index_requests_on_provider_id"
  add_index "requests", ["rfp_id"], :name => "index_requests_on_rfp_id"

  create_table "rfps", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "project_name"
    t.boolean  "nda_required"
    t.text     "project_description"
    t.text     "platform_requirements"
    t.integer  "budget"
    t.date     "due_date"
    t.string   "time_zone"
    t.string   "office_location"
    t.boolean  "general_liability_insurance"
    t.boolean  "professional_liability_insurance"
    t.text     "additional_services"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shortcode_url"
    t.string   "postal_code"
    t.date     "start_date"
    t.string   "duration"
  end

  create_table "service_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.boolean  "proficiency"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked",             :default => false, :null => false
    t.integer  "service_category_id"
    t.integer  "priority"
  end

  add_index "services", ["service_category_id"], :name => "index_services_on_service_category_id"

  create_table "time_blocks", :force => true do |t|
    t.integer "provider_id"
    t.date    "start"
    t.date    "end"
  end

  create_table "users", :force => true do |t|
    t.string   "email",             :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "provider_id"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count",                      :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "perishable_token",                 :default => "", :null => false
  end

  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

end
