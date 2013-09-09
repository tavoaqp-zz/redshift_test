class ChangeAccountIdsInTransfer < ActiveRecord::Migration
  def change
	change_column :transfers, :src_account_id, :string
	change_column :transfers, :dst_account_id, :string
  end
end
