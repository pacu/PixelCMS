class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.references :publisher
      t.references :publication
      t.string :object_type
      t.timestamps
    end

    add_index :roles, :object_type

  end
end
