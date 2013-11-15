require 'csv'

module Import
  class Ledger < ActiveRecord::Base
    belongs_to :user, inverse_of: :import_ledger
    mount_uploader :csv_file, CsvFileUploader

    MATCH_ORDER_STATUSES = %w(none new pending done).freeze
    SUPPORTED_HEADERS = [:brewery, :brew, :best_by, :count, :notes, :size, :vintage].freeze

    validates :csv_file, presence: true
    validate :csv_file_headers_found
    validates :match_order_status, inclusion: MATCH_ORDER_STATUSES
    validates :user, presence: true, uniqueness: true

    def csv_file_secure_token
      @csv_file_secure_token ||= SecureRandom.uuid
    end

    def extra_columns
      spreadsheet_headers - SUPPORTED_HEADERS
    end

    def matched_columns
      spreadsheet_headers & SUPPORTED_HEADERS
    end

    def spreadsheet
      @spreadsheet ||= load_spreadsheet_from(csv_file.read)
    end

    def update_match_order_status(status)
      update(match_order_status: status.to_s)
    end

    private

    def csv_file_headers_found
      return unless csv_file.present?

      unless missing_columns.empty?
        errors.add(:csv_file, "missing headers: #{missing_columns.collect{|h| h.to_s.humanize }.join(', ')}")
      end
    end

    def load_spreadsheet_from(file_contents)
      csv = CSV.new(file_contents, headers: :first_row, return_headers: true, header_converters: :symbol)
      csv.readline # read in the headers
      csv
    end

    def missing_columns
      SUPPORTED_HEADERS - spreadsheet_headers
    end

    def spreadsheet_headers
      Array(spreadsheet.headers)
    end

  end
end
