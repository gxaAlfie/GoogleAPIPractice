class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :token
      t.string :refresh_token
      t.string :provider
      t.string :uid
      t.string :email
      t.datetime :token_expiration

      t.timestamps
    end
  end
end
