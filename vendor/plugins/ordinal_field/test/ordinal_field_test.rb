require File.dirname(__FILE__) + '/test_helper'

%w(
ordinal_field pp
).each { |x| require x }

class OrdinalFieldTest < ActiveSupport::TestCase
  INPUT_VALUE = [['Eccles',2],['Neddie',1]]
  module CleanRoom
    class ARecord < ActiveRecord::Base
      ordinal_field :goons, INPUT_VALUE
    end
  end
  include CleanRoom
  # Replace this with your real tests.
  test "ordinals are defined and accessible" do
    assert_equal INPUT_VALUE, ARecord.ordinals[:goons]
  end
  test "ordinals values are accessible" do
    assert_equal [2,1], ARecord.ordinal_values(:goons)
  end
  test "ordinals labels are accessible" do
    assert_equal ['Eccles','Neddie'], ARecord.ordinal_labels(:goons)
  end
  test "out of range assignment creates an error" do
    record = ARecord.new :goons => 7
    record.valid?
    
    assert_equal record.errors[:goons].length, 1
  end
  test "out of range assignment creates an error specifying all legal values as their labels not values" do
    record = ARecord.new :goons => 7
    record.valid?
    INPUT_VALUE.map(&:first).each do |value|
      assert(Regexp.new(value.to_s) =~ record.errors[:goons].first, 
            "Error message #{record.errors[:goons].first} should contain all valid values as labels")
    end
  end
  # rails 3 doesn't call '% value' on message, a shame
  # test "out of range assignment creates an error specifies illegal value" do
  #   record = ARecord.new :goons => 7
  #   record.valid?
  #   assert(Regexp.new("can't be set to 7") =~ record.errors[:goons].first, 
  #         "Error message #{record.errors[:goons].first} should contain all valid values as labels")
  # end
end
