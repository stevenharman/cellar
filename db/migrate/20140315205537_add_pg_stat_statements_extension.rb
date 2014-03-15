class AddPgStatStatementsExtension < ActiveRecord::Migration
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS pg_stat_statements'
  end

  def down
    execute 'DROP EXTENSION pg_stat_statements'
  end
end
