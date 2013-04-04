namespace :scheduled do

  desc 'Reset all counters calculated by InventoryReport'
  task refresh_inventory_report: [:environment] do
    Brew.joins(:beers).cellared.uniq.find_each do |b|
      InventoryReport.calculate(b)
    end
  end

end
