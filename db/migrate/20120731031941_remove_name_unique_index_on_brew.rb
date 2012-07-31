class RemoveNameUniqueIndexOnBrew < ActiveRecord::Migration
  def change
    remove_index :brews, column: [:brewery_id, :name]
  end
end
