class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  # Call method
  process :set_content_type

  # https://coderwall.com/p/ryzmaa/use-imagemagick-to-create-optimised-and-progressive-jpgs
  process :optimize_jpeg

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    file_path = [
      'fallbacks',
      ([model.class.to_s.underscore, mounted_as, version_name].compact.join('_') + '.png')
    ].join '/'

    'http://' + ENV['HOST'] + ActionController::Base.helpers.image_path(file_path)
  end

  version :thumb, if: Proc.new {|new_upload| !new_upload.svg?} do
    process resize_to_fit: [150, 150]
  end

  version :small, if: Proc.new {|new_upload| !new_upload.svg?} do
    process resize_to_fit: [600, 600]
  end

  version :medium, if: Proc.new {|new_upload| !new_upload.svg?} do
    process resize_to_fit: [1200, 1200]
  end

  version :large, if: Proc.new {|new_upload| !new_upload.svg?} do
    process resize_to_fit: [1920, 1080]
  end

  # version :slide_blur, if: Proc.new {|new_upload| !new_upload.svg?} do
  #   process resize_to_fill: [890, 445]
  #   process :gaussian_blur
  # end

  def svg?
    content_type.ends_with? 'svg+xml'
  end

  def gaussian_blur
    manipulate! do |img|
      # docs at http://www.imagemagick.org/Usage/blur/#blur_args
      img.blur("0x35")
      img = yield(img) if block_given?
      img
    end
  end
end
