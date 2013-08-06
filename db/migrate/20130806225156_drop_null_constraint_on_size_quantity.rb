class DropNullConstraintOnSizeQuantity < ActiveRecord::Migration
  def change
    change_column :sizes, :quantity, :string, null: true
  end
end
