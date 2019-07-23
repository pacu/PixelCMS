class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_many :assignments
  has_many :roles, :through => :assignments

  accepts_nested_attributes_for :assignments, :roles

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :assignments_attributes, :assignments
  # attr_accessible :title, :body


  def has_role?(role_sym)
    roles.any? { |r| r.class.to_s.underscore.to_sym == role_sym }
  end
end
