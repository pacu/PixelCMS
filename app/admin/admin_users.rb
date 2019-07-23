ActiveAdmin.register AdminUser do

  # Story: As an Admin User I would like to modify
  # my profile without being asked for a new password

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

  # Story: As a Super Admin I would like to see all the users and their data
  index do
    column :name
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count

    default_actions
  end

  # Story: As an Admin User I would like to see my profile
  show do
    attributes_table do
      row :name
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
      panel 'Roles' do
        table_for admin_user.roles do
          column 'name' do |role|
            role.name
          end

        end
      end

    end
  end


  filter :email


  # As an Admin User I would like to modify my profile info
  form do |f|
    f.inputs 'Admin Details' do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation


    end
    f.inputs 'Roles' do
      f.has_many :assignments do |a|
        a.inputs 'roles' do
          if !a.object.nil?
            a.input :_destroy, :as => :boolean, :label => 'Destroy?'
          end

          a.input :role

        end


      end


    end
    f.actions
  end


end                                   
