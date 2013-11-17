module Import
  class CandidateBeerDecorator < ApplicationDecorator
    delegate_all

    CONFIDENCE_INDICATORS = { high: 'flag', medium: 'warning', none: 'ban' }.with_indifferent_access

    def label_link
      label = h.image_tag(brew.medium_image, alt: brew.name)
      h.link_to_if(matched?, label, brew) do
        label
      end
    end

    def brew_link
      h.link_to_if(matched?, brew.name, brew, title: brew.name) do
        brew.name
      end
    end

    def brewery_links
      if matched?
        h.render('brews/breweries', brew: brew)
      else
        brew.brewery
      end
    end

    def confidence_indicator(classes: [])
      classes = Array(classes).push(confidence).join(' ')
      inverse_icon = "#{CONFIDENCE_INDICATORS.fetch(confidence)} inverse"
      h.fa_stacked_icon(inverse_icon, class: classes, base: 'square')
    end

    def size
      model.size.full_name if model.size
    end
  end
end
