class AddIndexToImportLedgerUserId < ActiveRecord::Migration
  def change
    remove_index :import_ledgers, :user_id
    add_index :import_ledgers, :user_id, unique: true
  end
end
