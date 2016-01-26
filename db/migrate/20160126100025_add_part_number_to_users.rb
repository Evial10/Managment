class AddPartNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :trainee, :boolean
  end
end
