class ChangeScheduleDateNameInTransfer < ActiveRecord::Migration
  def change
	rename_column :transfers, :schedule_date, :scheduled_date
  end
end
