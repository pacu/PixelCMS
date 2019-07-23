class PDFUploader < CarrierWave::Uploader::Base
  require 'zipruby'
  # Include RMagick or ImageScience support:
  #include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  #Choose what kind of storage to use for this uploader:
  storage :fog
  # storage :s3

  configure do |c|
    c.fog_public = false # or false
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir

    "#{model.publication.product_code}/#{model.product_id}"
  end

  def cache_dir
    '/tmp/uploads'
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  def move_to_cache
    true
  end

  def move_to_store
    true
  end

  def filename
    "#{model.product_id}.#{model.pdf_zip.file.extension}" if original_filename
  end


  process :prepare_upload


  # this uploader receives a zip file with a pdf file inside
  # 1. checks that there is only one pdf file
  # 2. extracts and renames pdf file to tmp dir according to naming convention (product_id)
  # 3. creates thumbnails of the pdf file
  # 4. adds thumbnails to zip file
  # 5. updates pdf filename in zip
  # 6. uploads the thumbnails dir to public S3 dir.

  def prepare_upload
    require 'tmpdir'
    thumbs = nil

    Dir::mktmpdir { |path|
      thumb_dir = path+'/thumbnails'
      if !Dir.mkdir(thumb_dir, 0700)
        raise CarrierWave.ProcessingError.new("could not create temp file at #{path}")
      end
      zip_files_count = 0
      zip_file_index = 0
      # 1. checks that there is only one pdf file
      Zip::Archive.open(current_path) { |ar|
        n = ar.num_files

        n.times do |i|

          entry_name = ar.get_name(i)
          if entry_name =~ /.\.pdf$/i
            zip_files_count += 1
            zip_file_index = i
          end
        end


        if zip_files_count > 1
          raise CarrierWave::ProcessingError.new('there\'s more than one pdf file in your zip')
        else
          if zip_files_count <1
            raise CarrierWave::ProcessingError.new('unable to find pdf file in your zip')
          end
        end


        # 2. extracts and renames pdf file to tmp dir according to naming convention (product_id)
        extracted_pdf_path = "#{path}/#{model.product_id}.pdf"

        File.open(extracted_pdf_path, 'wb') { |pdf|

          ar.fopen(zip_file_index) do |f|
            pdf << f.read


          end

        }


        # 3. creates thumbnails of the pdf file
        thumbs = PdfProcessor.thumbs(extracted_pdf_path, {:width => 175, :height => 131}, 'PNG')

        thumbs[:thumbs].each_with_index do |t, index|
          t.write("#{thumb_dir}/#{index.to_s}.png")

        end
        thumbs[:thumbs2x].each_with_index do |t, index|
          t.write("#{thumb_dir}/#{index.to_s}@2x.png")

        end

        # 4. adds thumbnails to zip file

        ar.add_dir('thumbnails')

        Dir.glob(thumb_dir+'/*.png').each do |f|
          if File.directory?(f)
            raise CarrierWave::ProcessingError.new('An error occurred during thumbnail zipping process')
          else

            file_name = File.basename(f)
            ar.add_file("thumbnails/#{file_name}", f)

          end


        end

        # 5. updates pdf filename in zip
        if ar.get_name(zip_file_index).eql?("#{model.product_id}.pdf") == false
          File.open(extracted_pdf_path) do |f|
            ar.replace_io(zip_file_index, f)
          end
        end

      }
      # 6. uploads the thumbnails dir to public S3 dir
      #credentials = {:threads => 2}.merge(CarrierWave::Uploader::Base.fog_credentials)
      #
      #
      #credentials[:public]= true
      #base_directory = CarrierWave::Uploader::Base.fog_directory
      #directory = "/public/#{model.publication.product_code}/#{model.product_id}/thumbnails"
      #credentials[:destination_dir] = directory
      #S3Uploader.upload_directory(thumb_dir, base_directory, credentials)

    }

    #model.pdf_length = thumbs[:thumbs].count
    #model.save!
  end

  # Create different versions of your uploaded files:

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(zip)
  end


end