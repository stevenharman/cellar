class AddUniquenessConstraintToBrews < ActiveRecord::Migration
  def change
    remove_index :brews, :name
    add_index :brews, [:brewery_id, :name], unique: true
  end
end
