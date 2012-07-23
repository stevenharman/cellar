module WarehouseMap
  class EmptyImages < OpenStruct; end

  def self.boolean(raw)
    return unless raw

    raw.to_s == 'Y'
  end

  def self.images(raw)
    raw || EmptyImages.new
  end

  def self.year(raw)
    return unless raw

    Date.new(raw.to_i)
  end

end
