require 'carrierwave/processing/mime_types'

class SpreadsheetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  process :set_content_type

  def initialize(*)
    super
    self.fog_public = false
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  def extension_white_list
    %w(csv)
  end

  def store_dir
    "import/#{mounted_as}/#{model.id}"
  end

end
