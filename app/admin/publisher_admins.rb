ActiveAdmin.register PublisherAdmin do
  menu :parent => 'Roles'


  index do

    column :name
    column :publisher
    column :updated_at
    default_actions
  end
end
