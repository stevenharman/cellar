class CreateImportCandidateBeers < ActiveRecord::Migration
  def change
    create_table :import_candidate_beers do |t|
      t.references :import_ledger, index: true
      t.references :brew
      t.string :confidence
      t.integer :count, null: false, default: 1
      t.date :best_by
      t.integer :line_number, null: false, default: 0
      t.text :notes
      t.references :size
      t.integer :vintage
      t.hstore :source_row
    end
  end
end
