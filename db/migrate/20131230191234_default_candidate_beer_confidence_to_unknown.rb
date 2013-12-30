class DefaultCandidateBeerConfidenceToUnknown < ActiveRecord::Migration
  def change
    change_column :import_candidate_beers, :confidence, :string, default: :unknown, null: false
  end
end
