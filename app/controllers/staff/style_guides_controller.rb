module Staff
  class StyleGuidesController < ApplicationController

    def show
      flash.now[:success] = "Yay! This is what a :success looks like!"
      flash.now[:notice] = "Hey there! This is what a :notice looks like."
      flash.now[:error] = "Oh no... this is what an :error looks like!"
    end

  end
end
