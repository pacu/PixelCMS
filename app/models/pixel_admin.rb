class PixelAdmin < Role
  # attr_accessible :title, :body
  set_inheritance_column 'object_type'

end
