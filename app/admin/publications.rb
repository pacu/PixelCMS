ActiveAdmin.register Publication do


  action_item :only => [:show, :edit] do |p|
    link_to('Add new Issue', "./#{params[:id]}/issues/new")
  end
  show do |publication|
    attributes_table do
      row :name
      row :publisher
      row :publication_type
      row :product_code


    end
    panel "Issues" do
      table_for publication.issues do
        column :name
        column :issue_number
        column 'Product ID', :product_id
        column :is_free
        column :release_date
        column :actions do |issue|
          link_to :view, "/admin/publications/#{params[:id]}/issues/#{issue.id} "

        end
      end
    end

  end

  form do |f|
    f.inputs :publisher
    f.inputs :name
    f.inputs :publication_type
    f.inputs :product_code


    f.actions
  end

end
