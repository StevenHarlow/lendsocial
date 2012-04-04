# encoding: utf-8
require 'carrierwave/processing/mini_magick'

class UserPictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def default_url
    case version_name
    when :thumb
      "120x120.png"
    when :message
      "80x80.png"
    when :tiny
      "35x35.png"
    end
  end
  
  version :thumb do
    process :resize_to_fill => [120, 120]
    process :convert => 'png'
  end
  
  version :message, :from_version => :thumb do
    process :resize_to_fill => [80, 80]
    process :convert => 'png'
  end

  version :tiny, :from_version => :thumb do
    process :resize_to_fill => [35, 35]
    process :convert => 'png'
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  # def filename
  #   "something.jpg" if original_filename
  # end

end
