require 'csv'

module Import
  class Ledger < ActiveRecord::Base
    belongs_to :user, inverse_of: :import_ledger
    mount_uploader :csv_file, CsvFileUploader

    validates :csv_file, presence: true
    validates :user, presence: true, uniqueness: true
    validate :csv_file_headers_found

    def csv_file_secure_token
      @csv_file_secure_token ||= SecureRandom.uuid
    end

    private

    def csv_file_headers_found
      return unless csv_file.url

      csv = CSV.new(open(csv_file.url), headers: :first_row, header_converters: :symbol)
      csv.readline
      missing_headers = (SUPPORTED_HEADERS - Array(csv.headers))
      unless missing_headers.empty?
        errors.add(:csv_file, "missing headers: #{missing_headers.collect{|h| h.to_s.humanize }.join(', ')}")
      end
    end

    SUPPORTED_HEADERS = [:brewery, :brew, :best_by, :count, :notes, :size, :vintage]

  end
end
