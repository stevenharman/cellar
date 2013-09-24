module Import
  class Ledger < ActiveRecord::Base
    belongs_to :user, inverse_of: :import_ledger
    mount_uploader :spreadsheet, SpreadsheetUploader

    validates :user, presence: true
  end
end
