class AddMatchJobIdToImportLedgers < ActiveRecord::Migration
  def change
    add_column :import_ledgers, :match_job_id, :string, null: true
    add_index :import_ledgers, :match_job_id
  end
end
