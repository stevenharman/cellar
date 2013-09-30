require 'csv'

module Import
  class Ledger < ActiveRecord::Base
    belongs_to :user, inverse_of: :import_ledger
    mount_uploader :spreadsheet, SpreadsheetUploader

    validates :spreadsheet, presence: true
    validates :user, presence: true, uniqueness: true
    validate :spreadsheet_headers_found

    def spreadsheet_secure_token
      @spreadsheet_secure_token ||= SecureRandom.uuid
    end

    private

    def spreadsheet_headers_found
      csv = CSV.new(open(spreadsheet.url), headers: :first_row, header_converters: :symbol)
      csv.readline
      missing_headers = (SUPPORTED_HEADERS - Array(csv.headers))
      unless missing_headers.empty?
        errors.add(:spreadsheet, "missing headers: #{missing_headers.collect{|h| h.to_s.humanize }.join(', ')}")
      end
    end

    SUPPORTED_HEADERS = [:brewery, :brew, :best_by, :count, :notes, :size, :vintage]

  end
end
