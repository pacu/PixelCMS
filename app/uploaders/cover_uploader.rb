class CoverUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :fog
  # storage :s3

  configure do |c|
    c.fog_public = true # or false
  end


  def cache_dir
    '/tmp/uploads'
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "public/#{model.publication.product_code}/#{model.product_id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  def scale(new_scale) ## from 0 to 1
    manipulate! do |img|
      puts img.class
      puts img.methods.sort
      img.scale(new_scale)
      img = yield(img) if block_given?
      img
    end
  end

  # process :prepare_upload

  #def prepare_upload
  #
  #  #connection = Fog::Storage.new (CarrierWave.)
  #end

  # Create different versions of your uploaded files:
  version :small do
    process :scale => 0.5

    def full_filename (for_file = model.cover.file)
      "cover.#{model.cover.file.extension}"

    end
  end
  version :library do
    process :resize_to_limit => [175, 131]

    def full_filename (for_file = model.cover.file)
      "cover_library.#{model.cover.file.extension}"
    end
  end

  version :library2x do
    process :resize_to_limit => [350, 262]

    def full_filename (for_file = model.cover.file)
      "cover_library@2x.#{model.cover.file.extension}"
    end
  end

  def filename
    "cover@2x.#{model.cover.file.extension}" if original_filename
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end


end