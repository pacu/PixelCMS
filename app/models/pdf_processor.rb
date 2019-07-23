class PdfProcessor
  require 'RMagick'
  include Magick

  def self.pdf_to_images (pdf_path, destination_path, needs_resize, size)

    pdf = Magick::ImageList.new(pdf_path)

    pdf.each_with_index do |p, index|

      if needs_resize
        p.resize_to_fit!(size[:width], size[:height])
      end

      path = destination_path + '/' + index.to_s + '.png'

      p.write(path)

    end


  end

  # When provided with a base size, returns a hash with the following
  # { :thumbs => thumb_array, :thumbs2x => thumb_array_for_retina }
  # the base size will be duplicated for retina displays.

  def self.thumbs (pdf_path, size = {:width => 175, :height => 131}, img_format = 'PNG')


    pdf = Magick::ImageList.new(pdf_path)
    thumbs = Array.new(pdf.count)
    thumbs2x = Array.new(pdf.count)

    width = size[:width]
    height = size[:height]
    width2x = width *2
    height2x = height*2


    pdf.each_with_index do |p, index|
      thumbs2x[index] = p.resize_to_fit(width2x, height2x)
      thumbs2x[index].format=img_format

      thumbs[index] = thumbs2x[index].resize_to_fit(width, height)
      thumbs[index].format=img_format

    end

    return {:thumbs => thumbs, :thumbs2x => thumbs2x}

  end

end