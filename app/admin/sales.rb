ActiveAdmin.register Sale do
  menu parent: 'Financial'

  config.clear_action_items!


  index do
    selectable_column
    column :start_date
    column :end_date
    column :product_identifier
    column :quantity
    column :share_usd
    default_actions

  end


  action_item :only => :index do
    link_to 'Upload reports', :action => 'upload_csv'
  end


  collection_action :upload_csv do
    # The method defaults to :get
    # By default Active Admin will look for a view file with the same
    # name as the action, so you need to create your view at
    # app/views/admin/posts/upload_csv.html.haml (or .erb if that's your weapon)
  end

  collection_action :import_csv, :method => :post do
    # Do some CSV importing work here...
    #  begin
      Sale.import_csv(params[:dump][:file], params[:dump][:exchange_rate].to_f)
      flash[:notice]= 'CSV imported successfully!'
      redirect_to :action => :index
     # rescue
     #   redirect_to action: :index, error: 'Failed to import CSV'
     # end
  end
end
