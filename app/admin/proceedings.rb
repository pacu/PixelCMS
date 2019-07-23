ActiveAdmin.register Proceeding do
  menu parent: 'Financial'

  index do
    selectable_column
    column :publisher
    column :name , as: 'Period'
    column :start_date
    column :end_date
    column :deposit_date
    column :exchange_rate
    column :total_usd
    column :share_percent, as: 'author proceeding'
    column :share_ars, as: 'converted proceedings'
    column :payment_date
    default_actions

  end
  form do |f|
    f.inputs do

      f.input :publisher
      f.input :start_date, :as  => :datepicker
      f.input :end_date, :as => :datepicker
      f.input :deposit_date, :as => :datepicker
      f.input :exchange_rate
      f.input :name
      f.input :payment_date, as: :datepicker


    end
    f.actions
  end
end
