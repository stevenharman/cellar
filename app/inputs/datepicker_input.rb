class DatepickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    options = merge_wrapper_options(input_html_options, wrapper_options)
    # TODO: Use @builder#date_field when upgrading to Rails 4.
    date_inputs = @builder.text_field(attribute_name, {type: 'date'}.merge(options))

    icon = template.content_tag(:i, '', class: 'fa fa-calendar')
    date_inputs << template.content_tag(:span, icon, class: 'input-group-addon')

    template.content_tag(:div, date_inputs, class: 'input-group date')
  end
end

