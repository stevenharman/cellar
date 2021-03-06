require 'csv'

module Import
  class Ledger < ActiveRecord::Base
    belongs_to :user, inverse_of: :import_ledger
    has_many :candidate_beers, inverse_of: :ledger, foreign_key: :import_ledger_id, dependent: :destroy
    mount_uploader :csv_file, CsvFileUploader

    validates :csv_file, presence: true
    validate :csv_file_headers_found, if: -> { csv_file.present? }
    validate :csv_file_utf8_encoded,  if: -> { csv_file.present? }
    validates :match_order_status, inclusion: MatchOrder::STATUSES
    validates :user, presence: true, uniqueness: true

    def add_candidate(candidate_beer)
      candidate_beers << candidate_beer
      candidate_beer
    end

    def candidate_beer_matches
      candidate_beers.includes(:brew).order(:created_at)
    end

    def csv_file_secure_token
      @csv_file_secure_token ||= SecureRandom.uuid
    end

    def find_match(match_id)
      candidate_beer_matches.find(match_id)
    end

    def extra_columns
      spreadsheet_headers - IMPORTABLE_ATTRIBUTES
    end

    def find_candidate(id)
      candidate_beers.find(id)
    end

    def matched_columns
      spreadsheet_headers & IMPORTABLE_ATTRIBUTES
    end

    def spreadsheet
      @spreadsheet ||= load_spreadsheet_from(csv_file.read)
    end

    def update_match_order_status(status)
      update!(match_order_status: status.to_s)
    end

    private

    def csv_file_headers_found
      unless missing_columns.empty?
        errors.add(:csv_file, "missing headers: #{missing_columns.collect{|h| h.to_s.humanize }.join(', ')}")
      end
    end

    def csv_file_utf8_encoded
      unless csv_file.encoded_with?('utf-8')
        errors.add(:csv_file, 'invalid encoding: File must be UTF-8 encoded.')
      end
    end

    def load_spreadsheet_from(file_contents)
      csv = CSV.new(file_contents, headers: :first_row, return_headers: true, header_converters: :symbol)
      csv.readline # read in the headers
      csv
    end

    def missing_columns
      IMPORTABLE_ATTRIBUTES - spreadsheet_headers
    end

    def spreadsheet_headers
      Array(spreadsheet.headers)
    end

  end
end
