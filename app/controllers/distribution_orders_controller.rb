class DistributionOrdersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def update
    @order = DistributionOrder.prepare(distribution_params)
    @order = Clerk.new(current_cellar).distribute(@order)

    if @order.successful?
      flash[:notice] = "That #{@order.brew_name} was #{@order.status}!"
    else
      flash[:alert] = @order.errors.full_messages.join(". ")
    end

    respond_with @order, location: brew_path(@order.brew)
  end

  private

  def distribution_params
    params.slice(:beer_id, :status)
  end

end

