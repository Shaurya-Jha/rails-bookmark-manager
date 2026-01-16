class AddIndexAndConstraintsToUsers < ActiveRecord::Migration[8.0]
  def change
    # add unique index for performance and extra security
    add_index :users, :email, unique: true

    # ensure email and password_digest cannot be empty at the db level
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
  end
end
