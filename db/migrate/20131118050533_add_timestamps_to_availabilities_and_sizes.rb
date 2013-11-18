class AddTimestampsToAvailabilitiesAndSizes < ActiveRecord::Migration
  def change
    change_table :availabilities do |t|
      t.timestamps
    end

    change_table :sizes do |t|
      t.timestamps
    end
  end
end
