ActiveAdmin.register SuperAdmin do
  #we only want one super admin role
  #config.clear_action_items! if SuperAdmin.first


  menu :parent => 'Roles'

  show do


    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at

    end

  end

  #index do
  #
  #  column :name
  #  column :created_at
  #  column :updated_at
  #
  #
  #end
  controller do

    alias_method :create_super_admin, :create
    alias_method :update_super_admin, :update

    def create


      @super_admin = SuperAdmin.new

      @super_admin.name= params[:super_admin][:name]


      create_super_admin
    end


  end


end
