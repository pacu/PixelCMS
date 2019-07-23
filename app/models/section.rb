class Section < ActiveRecord::Base
  attr_accessible :title, :page_number, :issue, :contents_attributes, :contents
  belongs_to :issue
  has_many :contents
  accepts_nested_attributes_for :contents, :allow_destroy => true

  validates_presence_of :title
  validates :page_number, :presence => true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1}
  validates_uniqueness_of :title
  validates_associated :contents

  def page_number_valid?
    page_number <= issue.page_count
  end
end
