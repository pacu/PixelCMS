class Publisher < ActiveRecord::Base
  attr_accessible :name, :publications, :share_percent

  # has_many :publications, :dependent => :destroy
  # accepts_nested_attributes_for :publications
  validates_presence_of :name


  validates_presence_of :share_percent
  validates :share_percent, :numericality => { greater_than_or_equal_to: 0, less_than_or_equal_to: 100}


end
