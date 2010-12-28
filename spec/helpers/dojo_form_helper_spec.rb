require 'spec_helper'

describe DojoFormHelper do
  
  describe "#dojo_slider_select_tag" do
    it "renders options as index of values" do
      rendered = helper.dijit_form_slider_select_tag('x',{'one' => 'red', 'two' => 'blue'})
      rendered.should match(/option.*value=['"]0\1>one/)
    end
  end
  
end