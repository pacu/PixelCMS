class Content < ActiveRecord::Base

  mount_uploader :thumbnail, ContentImageUploader

  belongs_to :section
  attr_accessible :title,
                  :start_page,
                  :end_page,
                  :preview_text,
                  :section,
                  :thumbnail,
                  :section_id


  validates :title, :length => {:maximum => 100}, :presence => true
  validates :preview_text, :length => {:maximum => 300}, :allow_blank => true
  validates :start_page, :presence => true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1}
  validates :end_page, :presence => true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 1}

  def end_page_valid?
    self.end_page < self.start_page and self.section.issue.pages >= self.end_page
  end

  def start_page_valid?
    self.start_page > self.end_page and self.start_page <= self.section.issue.pages
  end

end
