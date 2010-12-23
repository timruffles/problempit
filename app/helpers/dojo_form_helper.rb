module DojoFormHelper
  def view_path file
    File.dirname(__FILE__) + "/../views/dojo/#{file}.erb"
  end
  def use_module module_name
    DojoHelper.modules << module_name
    module_name
  end
  def dijit_form_slider_tag name, options_for_select_or_range, options = {}
    upper_labels, lower_labels = options.delete(:upper_labels) || [], options.delete(:lower_labels) || []
    dijit_options = to_dojo_keys(case options_for_select_or_range
      when Range
        {:min => options_for_select_or_range.min, :max => options_for_select_or_range.max}.tap do |o|
          o[:discrete_values] = options[:discrete_values] if options[:discrete_values]
        end
      when Hash
        options_for_select_or_range
      else
        raise "#dijit_form_slider_tag expects select options as a hash or range"
    end.merge(options))
    use_module('dijit.form.Slider')
    render_template('form/horizontal_slider', binding)
  end
  def render_template view, var_bindings
    template = ERB.new(File.read(view_path(view)))
    template.result(var_bindings).html_safe
  end
  def to_dojo_keys hash
    Hash[*hash.map {|k,v| [k.to_s.camelize,v]}.flatten]
  end
end