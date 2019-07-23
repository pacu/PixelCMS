class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :publication
      t.string :name
      t.integer :issue_number
      t.integer :pdf_length
      t.date :release_date
      t.string :pdf_zip
      t.string :product_id


      t.string :cover
      t.string :newsstand_cover
      t.boolean :is_free

      t.string :app_store_description
      t.references :issue_state
      t.timestamps
    end
  end
end
