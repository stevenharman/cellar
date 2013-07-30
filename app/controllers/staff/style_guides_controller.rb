module Staff
  class StyleGuidesController < ApplicationController
    layout 'staff'

    def show
      flash.now[:success] = "Yay! This is what a :success looks like!"
      flash.now[:notice] = "Hey there! This is what a :notice looks like."
      flash.now[:error] = "Oh no... this is what an :error looks like!"

      @style_guide = StyleGuide.new.tap do |guide|
        guide.disabled_text = 'Lorem Ipsum dolor'
        guide.select_box = StyleGuide::SELECT_OPTIONS.sample
        guide.agree = true
        guide.radios = false
        guide.valid?
      end
    end

  end
end
