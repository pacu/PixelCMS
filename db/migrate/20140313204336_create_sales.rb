class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.date :start_date
      t.date :end_date
      t.string :upc
      t.string :isrc_isbn
      t.string :product_identifier
      t.integer :quantity
      t.float :partner_share
      t.float :extended_partner_share
      t.string :partner_share_currency
      t.string :sales_return
      t.string :apple_identifier
      t.string :seller_type
      t.string :label_studio
      t.string :grid
      t.string :product_type
      t.string :isan
      t.string :country
      t.float :customer_price
      t.string :customer_currency
      t.float :usd_exchange_rate
      t.string :promo_code
      t.string :preorder_flag
      t.float :share_usd
      t.references :publisher
      t.timestamps

    end

    add_index :sales, :product_identifier, :unique =>false

  end
end
