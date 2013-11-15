class ChangeDefaultForImportLedgerMatchOrderStatus < ActiveRecord::Migration
  def up
    change_column_default(:import_ledgers, :match_order_status, 'new')
  end

  def down
    change_column_default(:import_ledgers, :match_order_status, 'none')
  end
end
