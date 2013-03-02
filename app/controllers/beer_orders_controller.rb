class BeerOrdersController < ApplicationController
  before_filter :authenticate_user!

  def new
    brew = load_brew(params[:brew])
    return redirect_to brews_path, alert: t('beer_orders.missing_brew') unless brew

    @order = BeerOrder.new(brew: brew)
  end

  def create
    brew = load_brew(beer_order_params[:brew_id])
    @order = BeerOrder.new(beer_order_params.merge(brew: brew))
    receipt = current_cellar.stock_beer(@order)

    if receipt.success?
      success_message = t('beer_orders.success', count: @order.count, name: @order.brew_name)
      redirect_to(cellar_path(current_user), notice: success_message)
    else
      flash.now[:alert] = "Oops! #{receipt.error_messages.join(", ")}"
      render :new
    end
  end

  private

  def beer_order_params
    params[:beer_order]
  end

  def load_brew(brew_id)
    @brew ||= Brew.find_by_id(brew_id)
  end

end
