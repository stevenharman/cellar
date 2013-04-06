class StockOrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    brew = Brew.find_by_id(params[:brew])
    return redirect_to brews_path, alert: t('stock_orders.missing_brew') unless brew

    @order = StockOrder.new(brew: brew)
  end

  def create
    @order = StockOrder.prepare(stock_order_params)
    receipt = Clerk.new(current_cellar).procure(@order)

    if receipt.valid?
      flash[:notice] = t('stock_orders.success', count: @order.count, name: @order.brew_name)
    else
      flash.now[:alert] = "Oops! #{receipt.error_messages.join(", ")}"
    end

    respond_with(receipt, location: cellar_path(current_user))
  end

  private

  def stock_order_params
    params[:stock_order]
  end

end
