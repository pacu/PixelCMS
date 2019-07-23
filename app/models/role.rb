class Role < ActiveRecord::Base

  has_many :assignments
  has_many :admin_users, :through => :assignments

  set_inheritance_column 'object_type'

  attr_accessible :assignments, :admin_users, :name
  #attr_readonly :name


end
