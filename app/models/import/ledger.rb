module Import
  class Ledger < ActiveRecord::Base
    belongs_to :user, inverse_of: :import_ledger
    mount_uploader :spreadsheet, SpreadsheetUploader

    validates :spreadsheet, presence: true
    validates :user, presence: true

    def spreadsheet_secure_token
      @spreadsheet_secure_token ||= SecureRandom.uuid
    end

  end
end
