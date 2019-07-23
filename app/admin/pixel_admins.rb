ActiveAdmin.register PixelAdmin do
  #we only want one super admin role
 # config.clear_action_items! if PixelAdmin.first

  menu :parent => 'Roles'


end
