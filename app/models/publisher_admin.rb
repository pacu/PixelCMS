class PublisherAdmin < Role

  belongs_to :publisher
  attr_accessible :publisher, :publisher_id
  set_inheritance_column 'object_type'

end
