module SupplyChain

  def self.handle(order_params)
    BrewRequest.order(order_params[:id])
  end

end
