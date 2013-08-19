class StockOrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    brew = Brew.find_by_id(params[:brew])
    return redirect_to brews_path, flash: { error: t('flash.stock_orders.new.error') } unless brew

    @order = StockOrder.new(brew: brew, vintage: Date.current.year)
  end

  def create
    @order = StockOrder.prepare(stock_order_params)
    receipt = Clerk.new(current_cellar).procure(@order)

    if receipt.valid?
      flash[:success] = create_message(:success, @order)
    else
      flash.now[:error] = create_message(:error, @order)
    end

    respond_with(receipt, location: brew_path(@order.brew))
  end

  private

  def stock_order_params
    params.require(:stock_order).permit(:brew_id, :best_by, :count, :size_id, :notes, :vintage)
  end

  def create_message(key, order)
    t("flash.stock_orders.create.#{key}", count: order.count, name: order.brew_name)
  end

end
