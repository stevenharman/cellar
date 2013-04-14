class DistributionOrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def update
    @order = DistributionOrder.prepare(distribution_params)
    @order = Clerk.new(current_cellar).distribute(@order)

    if @order.successful?
      flash[:notice] = notice_message(@order)
    else
      flash[:alert] = alert_message(@order)
    end

    respond_with @order, location: brew_path(@order.brew) do |format|
      format.html { redirect_to brew_path(@order.brew) }
    end
  end

  private

  def distribution_params
    params.slice(:beer_id, :status)
  end

  def notice_message(order)
    t('flash.distribution_orders.update.notice', name: order.brew_name, status: order.status)
  end

  def alert_message(order)
    errors = order.errors.full_messages.join('. ')
    t('flash.distribution_orders.update.alert_html', errors: errors).html_safe
  end

end

