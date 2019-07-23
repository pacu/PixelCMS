class AddPaymentToProceeding < ActiveRecord::Migration
  def change
    add_column :proceedings, :payment_date, :Date
    add_column :proceedings, :name, :String
  end
end
