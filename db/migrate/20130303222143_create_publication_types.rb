class CreatePublicationTypes < ActiveRecord::Migration
  def change
    create_table :publication_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
