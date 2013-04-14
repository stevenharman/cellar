class StockOrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    brew = Brew.find_by_id(params[:brew])
    return redirect_to brews_path, alert: t('flash.stock_orders.new.alert') unless brew

    @order = StockOrder.new(brew: brew)
  end

  def create
    @order = StockOrder.prepare(stock_order_params)
    receipt = Clerk.new(current_cellar).procure(@order)

    if receipt.valid?
      flash[:notice] = create_message(:notice, @order)
    else
      flash.now[:alert] = create_message(:alert, @order)
    end

    respond_with(receipt, location: cellar_path(current_user))
  end

  private

  def stock_order_params
    params[:stock_order]
  end

  def create_message(key, order)
    t("flash.stock_orders.create.#{key}", count: order.count, name: order.brew_name)
  end

end
