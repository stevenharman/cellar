class RenameImportLedgerSpreadsheetToCsvFile < ActiveRecord::Migration
  def change
    rename_column(:import_ledgers, :spreadsheet, :csv_file)
  end
end
