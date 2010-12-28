require 'spec_helper'

describe Problem do
  it { should validate_presence_of(:name) }
end
