module Staff
  class StyleGuidesController < ApplicationController

    def show
      flash[:success] = "Yay! This is what a :success looks like!"
      flash[:notice] = "Hey there! This is what a :notice looks like."
      flash[:error] = "Oh no... this is what an :error looks like!"
    end

  end
end
