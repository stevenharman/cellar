class CsvFileUploader < CarrierWave::Uploader::Base
  process :set_content_type

  def initialize(*)
    super
    self.fog_public = false
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads/#{Rails.env}/#{mounted_as}"
  end

  def extension_whitelist
    %w(csv)
  end

  def filename
    "#{file.basename}-#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "uploads/#{Rails.env}/#{mounted_as}"
  end

  def encoded_with?(encoding)
    content = read.dup
    content.force_encoding(encoding).valid_encoding?
  end

  private

  def ledger
    model
  end

  def secure_token
    ledger.csv_file_secure_token
  end

end
