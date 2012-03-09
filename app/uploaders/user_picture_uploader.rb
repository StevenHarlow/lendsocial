# encoding: utf-8
require 'carrierwave/processing/mini_magick'

class UserPictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  storage :file
  # storage :fog
  
  # Make Carrierwave work on Heroku
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  process :convert => 'png'

  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  
  version :tiny do
    process :resize_to_fill => [35, 35] 
  end
  
  version :thumb do
    process :resize_to_fill => [120, 120]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  # def filename
  #   "something.jpg" if original_filename
  # end

end
