# encoding: utf-8

class ContentImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog


  configure do |c|
    c.fog_public = true # or false
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "public/#{model.publication.product_code}/#{model.product_id}/contents"
  end

  def cache_dir
    "/tmp/uploads/#{model.product_id}/contents"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumbnail_ipad_2x do
    process :resize_to_limit => [350, 262]

    def full_filename
      "content_ipad_#{model.start_page}_#{model.end_page}@2x.#{model.thumbnail.file.extension}"
    end
  end
  version :thumbnail_ipad do
    process :resize_to_limit => [175, 131]

    def full_filename
      "content_ipad_#{model.start_page}_#{model.end_page}.#{model.thumbnail.file.extension}"
    end
  end
  version :thumbnail_iPhone do
    process :resize_to_limit => [175, 131]

    def full_filename
      "content_iphone_#{model.start_page}_#{model.end_page}.#{model.thumbnail.file.extension}"
    end

  end
  version :thumbnail_iPhone_2x do
    process :resize_to_limit => [350, 262]

    def full_filename
      "content_iphone_#{model.start_page}_#{model.end_page}@2x.#{model.thumbnail.file.extension}"
    end

  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
