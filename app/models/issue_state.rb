class IssueState < ActiveRecord::Base

  has_one :next_state, :class_name => 'IssueState', :foreign_key => :next_state_id

  attr_accessible :name, :next_state, :next_state_id
  validates_presence_of :name
end
