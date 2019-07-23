ActiveAdmin.register Role do
  config.clear_action_items!

  index do
    column :id
    column :name
    default_actions
  end


end
