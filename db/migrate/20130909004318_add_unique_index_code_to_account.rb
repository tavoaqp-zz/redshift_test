class AddUniqueIndexCodeToAccount < ActiveRecord::Migration
  def change
	add_index :accounts, :code, :unique => true
  end
end
