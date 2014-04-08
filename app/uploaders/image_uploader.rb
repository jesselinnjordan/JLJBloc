 class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [300, 300]

  version :thumb do
    process :resize_to_fill => [50, 50]
  end
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end  