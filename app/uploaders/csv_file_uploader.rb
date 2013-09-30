require 'carrierwave/processing/mime_types'

class CsvFileUploader < CarrierWave::Uploader::Base
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

  def filename
    "#{file.basename}-#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "uploads/#{mounted_as}"
  end

  private

  def ledger
    model
  end

  def secure_token
    ledger.csv_file_secure_token
  end

end
