class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :issue
      t.string :title
      t.integer :page_number
      t.timestamps
    end
  end
end
