require 'spec_helper'

describe User do
  context "factories" do
    it "creates with no errors" do
      Factory(:user).errors.should be_empty
    end
  end
end
