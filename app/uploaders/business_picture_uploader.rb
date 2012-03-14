# encoding: utf-8
require 'carrierwave/processing/mini_magick'

class BusinessPictureUploader < CarrierWave::Uploader::Base
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
  
  def default_url
    case version_name
    when :tiny
      "35x35.png"
    when :message
      "80x80.png"
    when :thumb
      "120x80.png"
    when :loan
      "240x160.png"
    end
  end
  
  process :convert => 'png'
  
  version :tiny do
    process :resize_to_fill => [35, 35]
  end
  
  version :message do
    process :resize_to_fill => [80, 80]
  end
  
  version :thumb do
    process :resize_to_fill => [120, 80]
  end
  
  version :loan do
    process :resize_to_fill => [240, 160]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  # def filename
  #   "something.jpg" if original_filename
  # end

end
