class RenameImportLedgerMatchJobIdToMatchOrderStatus < ActiveRecord::Migration
  def up
    remove_column :import_ledgers, :match_job_id
    add_column :import_ledgers, :match_order_status, :string, null: false, default: 'none'
  end

  def down
    add_column :import_ledgers, :match_job_id, :string, null: true
    add_index :import_ledgers, :match_job_id
  end
end
