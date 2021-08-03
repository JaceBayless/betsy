class CreateEtsyAccounts < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :etsy_accounts do |t|
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_in
      t.string :state
      t.string :code_verifier
      t.datetime :last_token_refresh

      t.timestamps
    end
  end
end
