ActiveAdmin.register Issue do
  belongs_to :publication


  controller do
    alias_method :delete_issue, :destroy

    def destroy
      issue = Issue.find_by_product_id(params[:id])
      issue.remove_image!
      issue.remove_pdf_zip!
      delete_issue

    end
  end
  index do
    column :id
    column :name
    column :issue_number
    column :product_id, :label => 'Product ID'
    column :is_free
    column :release_date
    #  column :pdf_length

    default_actions
  end
  form(:html => {:multipart => true}) do |f|
    f.inputs do
      f.input :publication
      f.input :name
      f.input :issue_number
      f.input :pdf_zip, :as => :file
      f.input :pdf_length, :label => 'Total Pages', :hint => 'Total number of pages of this issue'
      f.input :product_id, :label => "Product ID", :hint => 'Must match the one on the App Store'
      f.input :release_date, :as => :datepicker

      f.input :app_store_description
      f.input :issue_state
      f.input :is_free
      f.input :cover, :as => :file


      f.has_many :sections do |s|
        s.input :title
        s.input :page_number
        s.input :_destroy, :as => :boolean, :required => false, :label => 'Remove'
        s.has_many :contents do |c|
          c.input :title
          c.input :start_page
          c.input :end_page
          c.input :preview_text
          c.input :thumbnail, :as => :file
          c.input :_destroy, :as => :boolean, :required => false, :label => 'Remove'
        end
      end

    end

    f.actions
  end

  show do |issue|
    attributes_table do
      row :publication
      row :name
      row :product_id
      row :issue_number
      row :issue_state
      row :is_free
      row :release_date
      #row :pdf_length
      row :pdf_zip
      row :cover
    end

    issue.sections.each do |section|
      panel "Section: #{section.title} page: #{section.page_number}" do
        table_for section.contents do |content|
          column :title
          column :start_page
          column :end_page
          column :preview_text
        end
      end
    end
  end
end
