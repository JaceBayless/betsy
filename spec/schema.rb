ActiveRecord::Schema.define do
  self.verbose = false

  create_table "etsy_accounts", force: :cascade do |t|
    t.string "access_token"
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "state"
    t.string "code_verifier"
    t.datetime "last_token_refresh"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
end
