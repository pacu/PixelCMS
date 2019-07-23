class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :section
      t.string :title
      t.integer :start_page
      t.integer :end_page
      t.string :preview_text
      t.string :thumbnail

      t.timestamps
    end
  end
end
