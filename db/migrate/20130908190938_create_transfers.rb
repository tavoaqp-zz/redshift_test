class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :src_account_id
      t.integer :dst_account_id
      t.float :amount
      t.float :tax
      t.date :schedule_date

      t.timestamps
    end
  end
end
