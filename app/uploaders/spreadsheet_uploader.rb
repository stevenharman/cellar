require 'carrierwave/processing/mime_types'

class SpreadsheetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  process :set_content_type
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "import/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(csv)
  end

end
