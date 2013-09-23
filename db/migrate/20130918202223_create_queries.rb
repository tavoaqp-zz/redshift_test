class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :title
      t.string :description
      t.integer :workspace_id
      t.integer :job_id
      t.string :output_path

      t.timestamps
    end
  end
end
