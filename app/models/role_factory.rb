class RoleFactory
  # attr_accessible :title, :body


  ROLES = %w[super_admin pixel_admin publisher_admin]

  def self.create_role(name)

    inc = ROLES.include? name.to_s
    if inc

      instance = name.to_s.classify.constantize.new
      instance.name = instance.class.to_s.underscore
      return instance
    end


    raise RoleFactoryException.new "role #{name} does not exist"


  end

  def self.roles

    return ROLES;
  end


end
