require 'spec_helper'
describe "Enum extension in lib/enum.rb" do
  
  module CleanRoom
    class Drum < ActiveRecord::Base
      define_enum :parts, ['snare','symbol']
    end
  end
  
  let (:drum) { Drum.new }
  it "defines values_of_#field method" do
    drum.values_for_parts
  end
  it "validates values are in enum set" do
    drum.attributes = 'guitar'
    drum.should_not be_valid
  end
  it "validates values are not in enum set" do
    drum.attributes = 'snare'
    drum.should be_valid
  end
  
end