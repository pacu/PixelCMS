ActiveAdmin.register PublicationAdmin do
  menu :parent => 'Roles'


  index do
    column :name
    column :publication
    default_actions

  end


end
