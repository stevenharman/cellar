class StockOrderReceipt

  def initialize(order, beers)
    @order = order
    @beers = Array(beers)
  end

  def errors
    @errors ||= build_errors
  end

  def error_messages
    errors.full_messages
  end

  def valid?
    @errors = nil
    [@order, @beers].flatten.all?(&:valid?)
  end

  private

  def build_errors
    if a_beer = @beers.first
      a_beer.errors.full_messages.each do |message|
        @order.errors.add(:base, "Beer: #{message}")
      end
    end

    @order.errors
  end

end
