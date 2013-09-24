class CreateImportLedgers < ActiveRecord::Migration
  def change
    create_table :import_ledgers do |t|
      t.references :user, index: true
      t.string :spreadsheet

      t.timestamps
    end
  end
end
