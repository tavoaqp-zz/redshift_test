class AddTotalToAccount < ActiveRecord::Migration
  def change
	add_column :accounts, :total, :float
  end
end
