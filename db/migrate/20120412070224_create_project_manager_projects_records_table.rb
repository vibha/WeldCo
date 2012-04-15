class CreateProjectManagerProjectsRecordsTable < ActiveRecord::Migration
  def change
    create_table :project_manager_projects_records do |t|
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
