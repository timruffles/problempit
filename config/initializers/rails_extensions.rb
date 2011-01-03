class ActionView::Helpers::FormBuilder
  # uses dojo_form_helper to generate an ordinal selector
  def ordinal_field(field, options = {})
    dijit_form_slider_tag field, @object.class.ordinal_values(field), @object.class.ordinal_labels(field), @object.class.ordinal_values(field).length
  end
end