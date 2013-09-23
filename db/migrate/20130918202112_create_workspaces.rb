class CreateWorkspaces < ActiveRecord::Migration
  def change
    create_table :workspaces do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.integer :project_id
      t.timestamps
    end
  end
end
