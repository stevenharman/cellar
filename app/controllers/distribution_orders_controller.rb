class DistributionOrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def update
    @order = DistributionOrder.prepare(distribution_params)
    @order = Clerk.new(current_cellar).distribute(@order)

    if @order.successful?
      flash[:success] = success_message(@order)
    else
      flash[:error] = error_message(@order)
    end

    respond_with @order, location: brew_path(@order.brew) do |format|
      format.html { redirect_to brew_path(@order.brew) }
    end
  end

  private

  def distribution_params
    params.require(:order).permit(:beer_id, :status)
  end

  def success_message(order)
    t('flash.distribution_orders.update.success', name: order.brew_name, status: order.status)
  end

  def error_message(order)
    errors = order.errors.full_messages.join('. ')
    t('flash.distribution_orders.update.error_html', errors: errors).html_safe
  end

end

