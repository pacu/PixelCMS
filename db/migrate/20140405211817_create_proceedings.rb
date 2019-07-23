class CreateProceedings < ActiveRecord::Migration
  def change
    create_table :proceedings do |t|

      t.date :start_date
      t.date :end_date
      t.references :publisher
      t.float :total_usd
      t.date :deposit_date
      t.float :exchange_rate
      t.float :share_percent

      t.timestamps
    end
  end
end
