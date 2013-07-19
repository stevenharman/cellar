module Staff
  class StyleGuide
    extend  ActiveModel::Naming
    include ActiveModel::Validations
    include ActiveModel::Conversion

    SELECT_OPTIONS = (1..10).to_a

    attr_accessor :text, :text_with_error, :disabled_text, :textarea,
      :select_box, :agree, :check_boxes, :radios

    validates :text_with_error, presence: true

    def persisted?; false; end

  end
end
