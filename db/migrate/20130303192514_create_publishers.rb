class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name
      t.float :share_percent

      t.timestamps
    end
  end
end
