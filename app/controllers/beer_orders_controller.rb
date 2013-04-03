class BeerOrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    brew = Brew.find_by_id(params[:brew])
    return redirect_to brews_path, alert: t('beer_orders.missing_brew') unless brew

    @order = BeerOrder.new(brew: brew)
  end

  def create
    @order = BeerOrder.prepare(beer_order_params)
    receipt = Clerk.new(current_cellar).procure(@order)

    if receipt.valid?
      flash[:notice] = t('beer_orders.success', count: @order.count, name: @order.brew_name)
    else
      flash.now[:alert] = "Oops! #{receipt.error_messages.join(", ")}"
    end

    respond_with(receipt, location: cellar_path(current_user))
  end

  private

  def beer_order_params
    params[:beer_order]
  end

end
