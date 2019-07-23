class Issue < ActiveRecord::Base
  mount_uploader :pdf_zip, PDFUploader
  mount_uploader :cover, CoverUploader


  attr_accessible :pdf_length,
                  :publication,
                  :publication_id,
                  :issue_state_id,
                  :issue_state,
                  :pdf_zip,
                  :app_store_description,
                  :name, :product_id,
                  :issue_number,
                  :release_date,
                  :cover,
                  :newsstand_cover,

                  :is_free,
                  :sections,

                  :sections_attributes


  has_many :sections
  belongs_to :publication
  belongs_to :issue_state
  accepts_nested_attributes_for :sections, :allow_destroy => true
  validates_uniqueness_of :product_id
  validates_presence_of :app_store_description, :name, :product_id, :issue_number, :release_date
  validates :issue_number, :numericality => {:greater_than_or_equal_to => 1}
  validates_associated :sections

  validates_associated :issue_state
  validates :pdf_length, :presence => true, :numericality => {:greater_than_or_equal_to => 0, :only_integer => true}


end
