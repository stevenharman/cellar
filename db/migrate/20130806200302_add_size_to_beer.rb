class AddSizeToBeer < ActiveRecord::Migration
  def change
    add_reference :beers, :size, index: true
  end
end
