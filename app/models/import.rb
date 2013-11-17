module Import
  IMPORTABLE_ATTRIBUTES = %i(brewery brew best_by count notes size vintage).freeze

  def self.table_name_prefix
    'import_'
  end
end
