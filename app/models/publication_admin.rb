class PublicationAdmin < Role
  set_inheritance_column 'object_type'

  belongs_to :publication
  attr_accessible :publication, :publication_id
end