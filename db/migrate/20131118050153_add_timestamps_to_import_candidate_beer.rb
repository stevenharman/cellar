class AddTimestampsToImportCandidateBeer < ActiveRecord::Migration
  def change
    change_table :import_candidate_beers do |t|
      t.timestamps
    end
  end
end
