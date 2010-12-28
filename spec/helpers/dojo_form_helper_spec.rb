require 'spec_helper'

describe DojoFormHelper do
  
  describe "#dojo_slider_select_tag" do
    let(:rendered) { rendered = helper.dijit_form_slider_select_tag('x',[['one','red'], ['two','blue']]) }
    it "renders options as index of values" do
      rendered.should match(/discreteValues=.2/)
    end
    it "renders labels in order" do
      rendered.should match(/one.*two/m)
    end
  end
  
end