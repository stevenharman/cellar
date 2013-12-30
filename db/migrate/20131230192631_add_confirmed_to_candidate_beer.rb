class AddConfirmedToCandidateBeer < ActiveRecord::Migration
  def change
    add_column :import_candidate_beers, :confirmed, :boolean, default: false, null: false
    add_index :import_candidate_beers, :confirmed
  end
end
