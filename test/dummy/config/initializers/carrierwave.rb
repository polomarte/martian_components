CarrierWave.configure do |config|
  config.enable_processing = false if Rails.env.test?
  config.storage = :file
end

# https://github.com/jnicklas/carrierwave/wiki/How-to%3A-Specify-the-image-quality
module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end
