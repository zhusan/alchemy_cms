require "digest/md5"
require 'carrierwave/processing/mini_magick'
class WebfileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :qiniu
  self.qiniu_bucket = "zs-test"
  self.qiniu_bucket_domain = "zs-test.qiniudn.com"
  self.qiniu_protocal = 'http'
  self.qiniu_can_overwrite = true
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  
  def qiniu_async_ops
    commands = []
    %W(small medium large).each do |style|
      commands << "http://#{self.qiniu_bucket_domain}/#{self.store_dir}/#{self.filename}/#{style}"
    end
    commands
  end
end
