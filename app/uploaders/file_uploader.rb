class FileUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    file_path = [
      'fallbacks',
      [model.class.to_s.underscore, "#{mounted_as}.png"].compact.join('_')
    ].join '/'

    ActionController::Base.helpers.image_path(file_path)
  end
end
