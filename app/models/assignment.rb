class Assignment < ActiveRecord::Base


  belongs_to :admin_user
  belongs_to :role


  attr_accessible :admin_user, :role, :role_id

end
