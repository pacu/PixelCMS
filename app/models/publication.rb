class Publication < ActiveRecord::Base
  attr_accessible :product_code,
                  :name, :issues,
                  :publisher,
                  :publication_type,
                  :publication_type_id,
                  :publisher_id,
                  :issues_attributes
  has_many :issues
  belongs_to :publisher
  belongs_to :publication_type
  accepts_nested_attributes_for :issues

  validates_associated :publisher
  validates_associated :publication_type
  validates_associated :issues

  validates_presence_of :name, :product_code

end
