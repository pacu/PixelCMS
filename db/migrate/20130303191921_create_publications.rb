class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.references :publisher
      t.references :publication_type

      t.string :name
      t.string :product_code
      t.timestamps
    end

    add_index :publications, :product_code
  end
end
