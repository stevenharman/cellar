class DatepickerInput < SimpleForm::Inputs::Base
  def input
    date_inputs = @builder.text_field(attribute_name, input_html_options)
    date_inputs << @builder.hidden_field(attribute_name, { id: nil, class: "#{attribute_name}-alt"})

    icon = template.content_tag(:i, '', class: 'icon-calendar')
    date_inputs <<  template.content_tag(:span, icon, class: 'add-on')

    template.content_tag(:div, date_inputs, class: 'input-append date')
  end
end

