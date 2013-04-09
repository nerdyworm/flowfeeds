class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fill => [36, 36]
  end

  version :medium do
    process :resize_to_fill => [140, 140]
  end

  def filename
    "image.jpg" if original_filename
  end
end
