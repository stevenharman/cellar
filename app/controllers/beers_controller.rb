class BeersController < ApplicationController
  before_filter :authenticate_user!

  def new
    brew_id = params[:brew]
    return redirect_to brews_path unless brew_id

    @beer = Brew.find(brew_id).beers.build
    @beer_count = 1
  end

  def create
    order = BeerOrder.new(params[:beer])
    receipt = current_cellar.stock_beer(order)

    if receipt.success?
      redirect_to(cellar_path(current_user), notice: "Added #{order.count} #{receipt.brew_name} to your cellar!")
    else
      @beer = receipt.example_beer
      @beer_count = order.count

      flash.now[:alert] = "Oops! #{receipt.error_messages.join(", ")}"
      render :new
    end
  end

end
