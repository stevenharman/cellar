class RemoveConfirmedFromImportCandidateBeer < ActiveRecord::Migration
  def change
    remove_column :import_candidate_beers, :confirmed
  end
end
