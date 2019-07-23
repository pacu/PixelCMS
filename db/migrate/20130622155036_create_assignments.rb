class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :role
      t.references :admin_user
      t.timestamps
    end
  end
end
